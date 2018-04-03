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
export TSLPACK_VERSION := 1.0.1

# Function definitions
working_dir_of_normal_packed = $(BUILD_LOCATION)/$(1:%_$(PKG_ARCH).tpm.tar=%)/$(PKG_ARCH)
built_of_normal_packed = $(call working_dir_of_normal_packed,$(1))/$(1)
built_of_normal_pkg = $(BUILD_LOCATION)/$(1)/$(PKG_ARCH)/$(1)_$(PKG_ARCH).tpm.tar

# Packages to build
# <package name>-<version triple>
NORMAL_PKGS := \
		alsa-lib \
		alsa-utils \
		amhello \
		bash \
		basic_fhs \
		bc \
		binutils \
		cifs-utils \
		e2fsprogs \
		elfutils \
		eudev \
		expat \
		file \
		findutils \
		gdbm \
		glibc \
		grep \
		grub \
		gmp \
		gzip \
		iana-etc \
		iproute2 \
		isc-dhcp-client \
		kbd \
		kmod \
		less \
		talloc \
		tslegacy-bootscripts \
		libffi \
		linux \
		linux-headers \
		mpc \
		mpfr \
		ncurses \
		ntfs-3g \
		openssl \
		pkg-config \
		procps-ng \
		python \
		python3 \
		readline \
		sed \
		shadow \
		sysvinit \
		tar \
		tpm \
		tslegacy-sysconfig \
		tslegacy-utils \
		tzdata \
		util-linux \
		vim \
		zlib

# Packages that shall be installed with a general installation scheme
NORMAL_TO_INSTALL_PKGS := $(NORMAL_PKGS)

# These packages are normal apart from their installation procedure
NORMAL_PKGS += coreutils

# The built packed forms of normal packages
# The build artifact of a normal package is its packed shape therefore
# NORMAL_PACKED_PKGS could also been named BUIT_NORMAL_PKGS.
NORMAL_PACKED_PKGS := $(foreach PKG,$(NORMAL_PKGS),$(call built_of_normal_pkg,$(PKG)))

PKGS := $(NORMAL_PKGS)
PACKED_PKGS := $(NORMAL_PACKED_PKGS)

# GCC and associated libraries
GCC_LIBS :=	libgcc \
			libstdc++ \
			libmpx \
			libvtv \
			libssp \
			libatomic \
			libquadmath

GCC_AND_LIBS := gcc $(GCC_LIBS)

GCC_SUBDIRS :=	gcc \
				libgcc \
				libstdc++ \
				libmpx \
				libvtv \
				libssp \
				libatomic \
				libquadmath

PACKED_GCC_AND_LIBS := $(join $(GCC_SUBDIRS:%=$(BUILD_LOCATION)/gcc/$(PKG_ARCH)/%/), \
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
$(call built_of_normal_pkg,linux): gcc_installed \
	bc_installed openssl_installed elfutils_installed

# The packages below depend on util linux to simplify the dependency graph.
$(call built_of_normal_pkg,alsa-utils): alsa-lib_installed
$(call built_of_normal_pkg,alsa-lib): util-linux_installed
$(call built_of_normal_pkg,ntfs-3g): util-linux_installed
$(call built_of_normal_pkg,isc-dhcp-client): util-linux_installed file_installed

$(call built_of_normal_pkg,cifs-utils): talloc_installed
$(call built_of_normal_pkg,talloc): python_installed
$(call built_of_normal_pkg,python3): libffi_installed expat_installed \
	gdbm_installed ncurses_installed

$(call built_of_normal_pkg,python): libffi_installed expat_installed \
	gdbm_installed ncurses_installed

$(call built_of_normal_pkg,e2fsprogs): util-linux_installed
$(call built_of_normal_pkg,tslegacy-utils): util-linux_installed
$(call built_of_normal_pkg,vim): ncurses_installed
$(call built_of_normal_pkg,tpm): glibc_installed

# Not each of the following packages may depend on coreutils however this
# dependency lowers the complexity of the dependency graph and as this
# Makefile is not parallel it is no performance issue.
$(call built_of_normal_pkg,file): coreutils_installed zlib_installed
$(call built_of_normal_pkg,gdbm): coreutils_installed
$(call built_of_normal_pkg,libffi): coreutils_installed
$(call built_of_normal_pkg,expat): coreutils_installed
$(call built_of_normal_pkg,findutils): coreutils_installed
$(call built_of_normal_pkg,grep): coreutils_installed
$(call built_of_normal_pkg,sed): coreutils_installed
$(call built_of_normal_pkg,tar): coreutils_installed
$(call built_of_normal_pkg,gzip): coreutils_installed
$(call built_of_normal_pkg,tslegacy-bootscripts): coreutils_installed
$(call built_of_normal_pkg,elfutils): coreutils_installed
$(call built_of_normal_pkg,util-linux): eudev_installed ncurses_installed
$(call built_of_normal_pkg,eudev): coreutils_installed \
	tslegacy-sysconfig_installed

$(call built_of_normal_pkg,sysvinit): coreutils_installed \
	tslegacy-sysconfig_installed

$(call built_of_normal_pkg,kbd): coreutils_installed
$(call built_of_normal_pkg,less): coreutils_installed
$(call built_of_normal_pkg,grub): coreutils_installed

# Same thing here however with ncurses
$(call built_of_normal_pkg,coreutils): ncurses_installed
$(call built_of_normal_pkg,procps-ng): ncurses_installed
$(call built_of_normal_pkg,openssl): ncurses_installed
$(call built_of_normal_pkg,kmod): ncurses_installed
$(call built_of_normal_pkg,bash): ncurses_installed readline_installed
$(call built_of_normal_pkg,iana-etc): ncurses_installed
$(call built_of_normal_pkg,shadow): ncurses_installed \
	tslegacy-sysconfig_installed sed_installed

$(call built_of_normal_pkg,tslegacy-sysconfig): basic_fhs_installed

$(call built_of_normal_pkg,pkg-config): gcc_installed
$(call built_of_normal_pkg,iproute2): gcc_installed
$(call built_of_normal_pkg,bc): readline_installed ncurses_installed
$(call built_of_normal_pkg,amhello): gcc_installed

$(call built_of_normal_pkg,ncurses): gcc_installed \
	pkg-config_installed

$(call built_of_normal_pkg,readline): gcc_installed

$(PACKED_GCC_AND_LIBS): \
	mpc_installed mpfr_installed gmp_installed \
	binutils_installed zlib_installed

$(call built_of_normal_pkg,mpc): mpfr_installed
$(call built_of_normal_pkg,mpfr): gmp_installed
$(call built_of_normal_pkg,gmp): binutils_installed
$(call built_of_normal_pkg,binutils): zlib_installed
$(call built_of_normal_pkg,zlib): toolchain_adjusted

$(call built_of_normal_pkg,tzdata): glibc_installed

$(call built_of_normal_pkg,glibc): linux-headers_installed
$(call built_of_normal_pkg,linux-headers): basic_fhs_installed
$(call built_of_normal_pkg,basic_fhs): tool_links_created

toolchain_adjusted: glibc_installed

# General rules for building and packages and installing them to the runtime
# system (bootstrapping):
toolchain_adjusted: adjust_toolchain.sh
	cd $(TOOLS_DIR) && $(PWD)/adjust_toolchain.sh && > $(PWD)/$@

tool_links_created: create_tool_links.sh
	cd $(TPM_TARGET) && $(PWD)/create_tool_links.sh && > $(PWD)/$@

$(patsubst %,%_installed,$(NORMAL_TO_INSTALL_PKGS) $(GCC_LIBS)): \
	override PKG_NAME = $(patsubst %_installed,%,$@)
$(patsubst %,%_installed,$(NORMAL_TO_INSTALL_PKGS) $(GCC_LIBS)): \
	$(COLLECTING_REPO)/$(PKG_ARCH)/$$(PKG_NAME)_$(PKG_ARCH).tpm.tar $(TPM_CONF) | /tmp
	if $(TPM) --list-installed | grep -q "^$(PKG_NAME)$$"; then \
		$(TPM) --remove $(PKG_NAME); \
	fi && \
	$(TPM) --install $(PKG_NAME) && \
	> $@

# Special rule for gcc since a temporary symlink might have to be removed first
gcc_installed: $(COLLECTING_REPO)/$(PKG_ARCH)/gcc_$(PKG_ARCH).tpm.tar $(TPM_CONF) | /tmp
	if [ -L $(TPM_TARGET)/usr/lib/gcc ]; then rm $(TPM_TARGET)/usr/lib/gcc; fi && \
	if $(TPM) --list-installed | grep -q "^gcc$$"; then \
		$(TPM) --remove gcc; \
	else \
		rm -vf $(TPM_TARGET)/usr/lib/{libgcc_s.so{,.1},libstdc++.{a,so{,.6}}}; \
	fi && \
	$(TPM) --install gcc && \
	> $@

# Special rule for installing coreutils since the preliminary runtime system
# has some temporary symlinks which need to be removed no
coreutils_installed: \
	$(COLLECTING_REPO)/$(PKG_ARCH)/coreutils_$(PKG_ARCH).tpm.tar $(TPM_CONF) | /tmp
	if $(TPM) --list-installed | grep -q "^coreutils$$"; then \
		$(TPM) --remove coreutils; \
	else \
		rm -vf $(TPM_TARGET)/usr/bin/install && \
		rm -vf $(TPM_TARGET)/bin/{cat,dd,echo,ln,pwd,rm,stty}; \
	fi && \
	$(TPM) --install coreutils && \
	> $@

$(patsubst %,$(COLLECTING_REPO)/$(PKG_ARCH)/%,$(notdir $(NORMAL_PACKED_PKGS))): \
	$$(call built_of_normal_packed,$$(notdir $$@)) \
	| $(COLLECTING_REPO)/$(PKG_ARCH)
	cp -f $< $@

$(GCC_AND_LIBS:%=$(COLLECTING_REPO)/$(PKG_ARCH)/%_$(PKG_ARCH).tpm.tar): \
	$(BUILD_LOCATION)/gcc/$(PKG_ARCH)/$$(patsubst %_$(PKG_ARCH).tpm.tar,%,$$(notdir $$@))/$$(notdir $$@) \
	| $(COLLECTING_REPO)/$(PKG_ARCH)
	cp -f $< $@

$(NORMAL_PACKED_PKGS): FORCE
	cd $(patsubst %_$(PKG_ARCH).tpm.tar,%,$(notdir $@)) && $(MAKE)

$(PACKED_GCC_AND_LIBS): build_gcc

.PHONY: build_gcc
build_gcc:
	cd gcc && $(MAKE)

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
	cd gcc && $(MAKE) clean

.PHONY: clean_runtime
clean_runtime: clean_confirmation
	rm -rvf $(TPM_TARGET)/{bin,boot,etc,home,lib,lib64,media,mnt,opt,root,sbin,srv,tmp,usr,var}
	rm -vf *_installed tool_links_created

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
		gcc \
		tslegacy_packaging-$(TSLPACK_VERSION)
	tar -cJf tslegacy_packaging-$(TSLPACK_VERSION).tar.xz tslegacy_packaging-$(TSLPACK_VERSION)
	rm -rf tslegacy_packaging-$(TSLPACK_VERSION)

.PHONY: FORCE
FORCE:
