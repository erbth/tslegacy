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
PKGS := amhello-1.0.0 basic_fhs-3.0.0

# config
TPM_CONF = $(TPM_TARGET)/etc/tpm/config.xml
TOOLS_DIR = $(TPM_TARGET)/tools

# Automatically derived information
PACKED_PKGS = $(PKGS:%=%_$(PKG_ARCH).tpm.tar)
COLLECTED_PACKED_PKGS = $(PACKED_PKGS:%=$(COLLECTING_REPO)/$(PKG_ARCH)/%)
BUILT_PACKED_PKGS = $(join $(PKGS:%=$(BUILD_LOCATION)/%/$(PKG_ARCH)/), $(PACKED_PKGS))

.SECONDEXPANSION:

# The default rule ('main anchora' of the building process)
all_packages: $(PKGS:%=%_installed)
	> $@

# Dependencies between package builds, and other targets.
$(call built_of_pkg,amhello-1.0.0): basic_fhs-3.0.0_installed

# General rules for building and packages and installing them to the runtime
# system (bootstrapping):
%_installed: $(COLLECTING_REPO)/$(PKG_ARCH)/%_$(PKG_ARCH).tpm.tar $(TPM_CONF)
	eval PKG="$@" && \
	eval PKG="$${PKG%-*}" && \
	if $(TPM) --list-installed || kill $$$$ | grep -q "^$${PKG}$$"; then \
		$(TPM) --remove $${PKG}; \
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
	cd $(TOOLS_DIR) && \
	if [ -e bin/ld-old ]; then mv bin/{ld,ld-new} && mv bin/{ld-old,ld}; fi && \
	if [ -e "$(uname -m)-pc-linux-gnu/bin/ld-old" ]; then \
		mv $(uname -m)-pc-linux-gnu/bin/{ld,ld-new} && \
		mv $(uname -m)-pc-linux-gnu/bin/{ld-old,ld}; \
	fi

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
