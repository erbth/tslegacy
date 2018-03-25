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

# Function definitions
built_of_packed = $(BUILD_LOCATION)/$(1:%_$(PKG_ARCH).tpm.tar=%)/$(PKG_ARCH)/$(1)
built_of_pkg = $(BUILD_LOCATION)/$(1)/$(PKG_ARCH)/$(1)_$(PKG_ARCH).tpm.tar

# Packages to build
# <package name>-<version triple>
PKGS := amhello-1.0.0 \
		basic_fhs-3.0.0 \
		bc-1.7.1 \
		binutils-2.30.0 \
		gcc-7.3.0 \
		glibc-2.27.0 \
		gmp-6.1.2 \
		iproute2-4.15.0 \
		mpc-1.1.0 \
		mpfr-4.0.1 \
		readline-7.0.0 \
		tzdata-2018.4.0 \
		zlib-1.2.11

# config
TPM_CONF = $(TPM_TARGET)/etc/tpm/config.xml
export TOOLS_DIR = $(TPM_TARGET)/tools

# Automatically derived information
PACKED_PKGS = $(PKGS:%=%_$(PKG_ARCH).tpm.tar)
COLLECTED_PACKED_PKGS = $(PACKED_PKGS:%=$(COLLECTING_REPO)/$(PKG_ARCH)/%)
BUILT_PACKED_PKGS = $(join $(PKGS:%=$(BUILD_LOCATION)/%/$(PKG_ARCH)/), $(PACKED_PKGS))

.SECONDEXPANSION:
# TPM's database does not allow for multiple simultaneous tpm invocations.
.NOTPARALLEL:

# The default rule ('main anchora' of the building process)
all_packages: $(PKGS:%=%_installed)
	> $@

# Dependencies between package builds, and other targets.
$(call built_of_pkg,iproute2-4.15.0): toolchain_adjusted
$(call built_of_pkg,bc-1.7.1): ncurses-6.1.0_installed

$(call built_of_pkg,gcc-7.3.0): mpc-1.1.0_installed mpfr-4.0.1_installed
$(call built_of_pkg,gcc-7.3.0): gmp-6.1.2_installed binutils-2.30.0_installed
$(call built_of_pkg,gcc-7.3.0): zlib-1.2.11_installed

$(call built_of_pkg,mpc-1.1.0): binutils-2.30.0_installed
$(call built_of_pkg,mpfr-4.0.1): binutils-2.30.0_installed
$(call built_of_pkg,gmp-6.1.2): binutils-2.30.0_installed
$(call built_of_pkg,readline-7.0.0): toolchain_adjusted
$(call built_of_pkg,binutils-2.30.0): zlib-1.2.11_installed
$(call built_of_pkg,zlib-1.2.11): toolchain_adjusted

$(call built_of_pkg,tzdata-2018.4.0): glibc-2.27.0_installed

$(call built_of_pkg,glibc-2.27.0): linux-headers-4.15.13_installed
$(call built_of_pkg,linux-headers-4.15.13): tool_links_created

toolchain_adjusted: glibc-2.27.0_installed
tool_links_created: basic_fhs-3.0.0_installed

# General rules for building and packages and installing them to the runtime
# system (bootstrapping):
toolchain_adjusted:
	cd $(TOOLS_DIR) && $(PWD)/adjust_toolchain.sh && > $(PWD)/$@

tool_links_created:
	cd $(TPM_TARGET) && $(PWD)/create_tool_links.sh && > $(PWD)/$@

%_installed: $(COLLECTING_REPO)/$(PKG_ARCH)/%_$(PKG_ARCH).tpm.tar $(TPM_CONF)
	eval PKG="$@" && \
	eval PKG="$${PKG%-*}" && \
	if $(TPM) --list-installed || kill $$$$ | grep -q "^$${PKG}$$"; then \
		$(TPM) --remove $${PKG}; \
	else \
		if [ -L $(TPM_TARGET)/usr/lib/gcc ]; then rm $(TPM_TARGET)/usr/lib/gcc; fi; \
	fi && \
	$(TPM) --install $${PKG} && \
	> $@

$(COLLECTED_PACKED_PKGS): Makefile | $(COLLECTING_REPO)/$(PKG_ARCH)
$(COLLECTED_PACKED_PKGS): override PACKED = $(notdir $@)
$(COLLECTED_PACKED_PKGS): $$(call built_of_packed,$$(PACKED))
	cp -f $< $@

$(BUILT_PACKED_PKGS): override PACKED = $(notdir $@)
$(BUILT_PACKED_PKGS): FORCE
	cd $(PACKED:%_$(PKG_ARCH).tpm.tar=%) && $(MAKE)

$(TPM_CONF):
	install -dm755 $(dir $@)
	install -m 644 <(echo -e \
	"<?xml version=\"1.0\"?>\n\
	<tpm file_version=\"1.0\">\n\
	    <repo type=\"dir\">$(COLLECTING_REPO)</repo>\n\
	    <arch>$(PKG_ARCH)</arch>\n\
	</tpm>" || kill $$$$) $@

$(COLLECTING_REPO)/$(PKG_ARCH):
	mkdir -p $@

.PHONY: clean
clean: clean_runtime clean_build_location clean_toolchain
	rm -rvf all_packages

.PHONY: clean_toolchain
clean_toolchain: clean_confirmation
	cd $(TOOLS_DIR) && $(PWD)/restore_toolchain.sh && \
	rm -vf $(PWD)/toolchain_adjusted

.PHONY: clean_build_location
clean_build_location: $(PKGS:%=clean_pkg_%)

.PHONY: $(PKGS:%=clean_pkg_%)
$(PKGS:%=clean_pkg_%): clean_confirmation
	$(MAKE) -C $(@:clean_pkg_%=%) clean

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

.PHONY: FORCE
FORCE:
