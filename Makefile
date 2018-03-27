# Tab size: 4
SHELL := bash
TPM ?= tpm

ifndef BUILD_LOCATION
$(error BUILD_LOCATION not set)
endif

ifndef COLLECTING_REPO
$(error COLLECTING_REPO not set)
endif

ifndef TPM_TARGET
$(error TPM_TARGET not set)
endif

ifndef PKG_ARCH
$(error PKG_ARCH not set)
endif

# The version of the packaging scripts
export TSLPACK_VERSION := 1.0.0

# Function definitions
working_dir_of_normal_packed = $(BUILD_LOCATION)/$(1:%_$(PKG_ARCH).tpm.tar=%)/$(PKG_ARCH)
built_of_normal_packed = $(call working_dir_of_normal_packed,$(1))/$(1)

# Packages to build
# <package name>-<version triple>
NORMAL_PKGS := amhello-1.0.0 \
		basic_fhs-3.0.0 \
		bc-1.7.1 \
		binutils-2.30.0 \
		glibc-2.27.0 \
		gmp-6.1.2 \
		iana-etc-2.30.0 \
		iproute2-4.15.0 \
		linux-headers-4.15.13 \
		mpc-1.1.0 \
		mpfr-4.0.1 \
		ncurses-6.1.0 \
		pkg-config-0.29.2 \
		readline-7.0.0 \
		shadow-4.5.0 \
		tzdata-2018.4.0 \
		zlib-1.2.11

NORMAL_PACKED_PKGS := $(join $(NORMAL_PKGS:%=$(BUILD_LOCATION)/%/$(PKG_ARCH)/), \
	$(NORMAL_PKGS:%=%_$(PKG_ARCH).tpm.tar))

PKGS := $(NORMAL_PKGS)
PACKED_PKGS := $(NORMAL_PACKED_PKGS)

# helper macros to deal with 'normal' packages
built_of_normal_pkg = $(BUILD_LOCATION)/$(1)/$(PKG_ARCH)/$(1)_$(PKG_ARCH).tpm.tar

# GCC and associated libraries
GCC_VERSION :=	7.3.0
GCC :=		gcc-$(GCC_VERSION)
GCC_LIBS :=	libstdc++-$(GCC_VERSION) \
			libmpx-$(GCC_VERSION) \
			libvtv-$(GCC_VERSION) \
			libssp-$(GCC_VERSION) \
			libatomic-$(GCC_VERSION) \
			libquadmath-$(GCC_VERSION)

GCC_AND_LIBS := $(GCC) $(GCC_LIBS)

GCC_SUBDIRS :=	gcc \
				libstdc++ \
				libmpx \
				libvtv \
				libssp \
				libatomic \
				libquadmath

PACKED_GCC_AND_LIBS := $(join $(GCC_SUBDIRS:%=$(BUILD_LOCATION)/$(GCC)/$(PKG_ARCH)/%/), \
	$(GCC_AND_LIBS:%=%_$(PKG_ARCH).tpm.tar))

PACKED_PKGS += $(PACKED_GCC_AND_LIBS)
PKGS += $(GCC_AND_LIBS)

# config
TPM_CONF = $(TPM_TARGET)/etc/tpm/config.xml
export TOOLS_DIR = $(TPM_TARGET)/tools

# Automatically derived information
COLLECTED_PACKED_PKGS = $(patsubst %,$(COLLECTING_REPO)/$(PKG_ARCH)/%,$(notdir $(PACKED_PKGS)))

.SECONDEXPANSION:
# TPM's database does not allow for multiple simultaneous tpm invocations.
.NOTPARALLEL:

# The default rule ('main anchora' of the building process)
all_packages: $(COLLECTED_PACKED_PKGS)
	> $@

# Dependencies between package builds, and other targets.
# Not each of the following packages may depend on ncurses however this
# dependency lowers the complexity of the dependency graph and as this
# Makefile is not parallel it is no performance issue.
$(call built_of_normal_pkg,iana-etc-2.30.0): ncurses-6.1.0_installed
$(call built_of_normal_pkg,shadow-4.5.0): ncurses-6.1.0_installed

$(call built_of_normal_pkg,pkg-config-0.29.2): gcc-7.3.0_installed
$(call built_of_normal_pkg,iproute2-4.15.0): gcc-7.3.0_installed
$(call built_of_normal_pkg,bc-1.7.1): readline-7.0.0_installed ncurses-6.1.0_installed
$(call built_of_normal_pkg,amhello-1.0.0): gcc-7.3.0_installed

$(call built_of_normal_pkg,ncurses-6.1.0): gcc-7.3.0_installed \
	pkg-config-0.29.2_installed

$(call built_of_normal_pkg,readline-7.0.0): gcc-7.3.0_installed

$(PACKED_GCC_AND_LIBS): \
	mpc-1.1.0_installed mpfr-4.0.1_installed gmp-6.1.2_installed \
	binutils-2.30.0_installed zlib-1.2.11_installed

$(call built_of_normal_pkg,mpc-1.1.0): mpfr-4.0.1_installed
$(call built_of_normal_pkg,mpfr-4.0.1): gmp-6.1.2_installed
$(call built_of_normal_pkg,gmp-6.1.2): binutils-2.30.0_installed
$(call built_of_normal_pkg,binutils-2.30.0): zlib-1.2.11_installed
$(call built_of_normal_pkg,zlib-1.2.11): toolchain_adjusted

$(call built_of_normal_pkg,tzdata-2018.4.0): glibc-2.27.0_installed

$(call built_of_normal_pkg,glibc-2.27.0): linux-headers-4.15.13_installed
$(call built_of_normal_pkg,linux-headers-4.15.13): basic_fhs-3.0.0_installed
$(call built_of_normal_pkg,basic_fhs-3.0.0): tool_links_created

toolchain_adjusted: glibc-2.27.0_installed

# General rules for building and packages and installing them to the runtime
# system (bootstrapping):
toolchain_adjusted: adjust_toolchain.sh
	cd $(TOOLS_DIR) && $(PWD)/adjust_toolchain.sh && > $(PWD)/$@

tool_links_created: create_tool_links.sh
	cd $(TPM_TARGET) && $(PWD)/create_tool_links.sh && > $(PWD)/$@

$(patsubst %,%_installed,$(NORMAL_PKGS) $(GCC_LIBS)): \
	$$(patsubst %_installed,$(COLLECTING_REPO)/$(PKG_ARCH)/%_$(PKG_ARCH).tpm.tar,$$@) $(TPM_CONF) | /tmp
	eval PKG="$@" && \
	eval PKG="$${PKG%-*}" && \
	if $(TPM) --list-installed || kill $$$$ | grep -q "^$${PKG}$$"; then \
		$(TPM) --remove $${PKG}; \
	fi && \
	$(TPM) --install $${PKG} && \
	> $@

# Special rule for gcc since a temporary symlink might have to be removed first
$(GCC)_installed: $(COLLECTING_REPO)/$(PKG_ARCH)/$(GCC)_$(PKG_ARCH).tpm.tar $(TPM_CONF) | /tmp
	if [ -L $(TPM_TARGET)/usr/lib/gcc ]; then rm $(TPM_TARGET)/usr/lib/gcc; fi && \
	eval PKG="gcc" && \
	if $(TPM) --list-installed || kill $$$$ | grep -q "^$${PKG}$$"; then \
		$(TPM) --remove $${PKG}; \
	fi && \
	$(TPM) --install $${PKG} && \
	> $@

$(patsubst %,$(COLLECTING_REPO)/$(PKG_ARCH)/%,$(notdir $(NORMAL_PACKED_PKGS))): \
	$$(call built_of_normal_packed,$$(notdir $$@)) \
	Makefile | $(COLLECTING_REPO)/$(PKG_ARCH)
	cp -f $< $@

$(GCC_AND_LIBS:%=$(COLLECTING_REPO)/$(PKG_ARCH)/%_$(PKG_ARCH).tpm.tar): \
	$(BUILD_LOCATION)/$(GCC)/$(PKG_ARCH)/$$(patsubst %-$(GCC_VERSION)_$(PKG_ARCH).tpm.tar,%,$$(notdir $$@))/$$(notdir $$@) \
	Makefile | $(COLLECTING_REPO)/$(PKG_ARCH)
	cp -f $< $@

$(NORMAL_PACKED_PKGS): FORCE
	cd $(patsubst %_$(PKG_ARCH).tpm.tar,%,$(notdir $@)) && $(MAKE)

$(PACKED_GCC_AND_LIBS): build_gcc

.PHONY: build_gcc
build_gcc:
	cd $(GCC) && $(MAKE)

$(TPM_CONF):
	install -dm755 $(dir $@)
	install -m 644 <(echo -e \
	"<?xml version=\"1.0\"?>\n\
	<tpm file_version=\"1.0\">\n\
	    <repo type=\"dir\">$(COLLECTING_REPO)</repo>\n\
	    <arch>$(PKG_ARCH)</arch>\n\
	</tpm>" || kill $$$$) $@

/tmp:
	install -dm 1777 /tmp

$(COLLECTING_REPO)/$(PKG_ARCH):
	mkdir -p $@

.PHONY: clean
clean: clean_runtime clean_build_location clean_toolchain
	rm -vf all_packages

.PHONY: clean_toolchain
clean_toolchain: clean_confirmation
	cd $(TOOLS_DIR) && $(PWD)/restore_toolchain.sh && \
	rm -vf $(PWD)/toolchain_adjusted

.PHONY: clean_build_location
clean_build_location: $(PKGS:%=clean_pkg_%)

.PHONY: $(PKGS:%=clean_pkg_%)
$(NORMAL_PKGS:%=clean_pkg_%): clean_confirmation
	cd $(@:clean_pkg_%=%) && \
	$(MAKE) clean

$(GCC_AND_LIBS:%=clean_pkg_%): clean_gcc_and_libs
.PHONY: clean_gcc_and_libs
clean_gcc_and_libs: clean_confirmation
	cd $(GCC) && $(MAKE) clean

.PHONY: clean_runtime
clean_runtime: clean_confirmation
	rm -rvf $(TPM_TARGET)/{bin,boot,etc,home,lib,lib64,media,mnt,opt,root,sbin,srv,tmp,usr,var}
	rm -vf *_installed

.PHONY: clean_confirmation
clean_confirmation:
	@ echo "The current runtime system and the build location will be lost," && \
	echo "and the adjustment of the toolchain be reversed." && \
	echo && \
	echo "Do you really want to proceed [y/N]?" && \
	read -n1 -s && [ "$$REPLY" == "y" ]

.PHONY: dist
dist:
	mkdir tslegacy_packaging-$(TSLPACK_VERSION)
	cp -a \
		Makefile \
		adjust_toolchain.sh \
		create_tool_links.sh \
		restore_toolchain.sh \
		set_env.sample \
		update_playground.sh \
		$(NORMAL_PKGS) \
		$(GCC) \
		tslegacy_packaging-$(TSLPACK_VERSION)
	tar -cJf tslegacy_packaging-$(TSLPACK_VERSION).tar.xz tslegacy_packaging-$(TSLPACK_VERSION)
	rm -rf tslegacy_packaging-$(TSLPACK_VERSION)

.PHONY: FORCE
FORCE:
