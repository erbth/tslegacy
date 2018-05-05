# Tab size: 4
# The first thing that needs to be saved:
THIS_MAKEFILE := $(lastword $(MAKEFILE_LIST))

# Programs
SHELL := bash
TPM ?= tpm

# Configure Make
.SECONDEXPANSION:

# TPM's database does not allow concurrent installation
.NOTPARALLEL:

# Makefile utilities
include makefile_utilities.mk

# The version of the packaging scripts
TSLPACK_VERSION := 1.0.3

# Basic automatically derived information
export PACKAGING_RESOURCE_DIR := $(call remove_trailing_slash,$(PWD)/$(dir $(THIS_MAKEFILE)))

# Configuration
UTILS := $(PACKAGING_RESOURCE_DIR)/utils
RM_OLD_PKG_VERSIONS := $(UTILS)/remove_old_package_versions.native

TPM_CONF = $(TPM_TARGET)/etc/tpm/config.xml
export TOOLS_DIR = $(TPM_TARGET)/tools

# Check the environment
ifndef PACKAGING_BASE
$(error PACKAGING_BASE not set)
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

# Automatically derived and retrieved information
PACKAGING_LOCATION := $(PACKAGING_BASE)/packaging_location

STATE_DIR := $(PACKAGING_BASE)/state
export COLLECTING_DIR := $(COLLECTING_REPO)/$(PKG_ARCH)

SOURCE_PACKAGES := \
	bash \
	basic_fhs \
	bc \
	binutils \
	bzip2 \
	coreutils \
	eudev \
	gcc \
	glibc \
	gmp \
	grub \
	iana-etc \
	iproute2 \
	kbd \
	kmod \
	less \
	licenses \
	linux-headers \
	mpc \
	mpfr \
	ncurses \
	openssl \
	pkg-config \
	procps-ng \
	readline \
	shadow \
	sysvinit \
	tslegacy-sysconfig \
	tzdata \
	util-linux \
	zlib

# TODO: coreutils bash dependencies for packaging scripts

include $(SOURCE_PACKAGES:%=%/description.mk)

ALL_TSL_PACKAGES := $(foreach SRC,$(SOURCE_PACKAGES),$($(SRC)_TSL_PKGS))

# Packages in the collecting repo
ALL_COLLECTED := $(ALL_TSL_PACKAGES:%=$(STATE_DIR)/%_collected)

# Rules
.PHONY: all_packages_collected
all_packages_collected: $(ALL_COLLECTED)

# Building the packages
$(ALL_COLLECTED): override PKG = $(patsubst $(STATE_DIR)/%_collected,%,$@)
$(ALL_COLLECTED): override SRC = $($(PKG)_TSL_SRC_PKG)
$(ALL_COLLECTED): $(STATE_DIR)/$$(SRC)_built
	> $@

$(SOURCE_PACKAGES:%=$(STATE_DIR)/%_built): override SRC = $(patsubst %_built,%,$(notdir $@))
$(SOURCE_PACKAGES:%=$(STATE_DIR)/%_built): \
	$(SOURCE_LOCATION)/$$($$(SRC)_SRC_ARCHIVE) \
	$(STATE_DIR)/$$(SRC)_clean_to_build | $(COLLECTING_DIR) $(STATE_DIR)
	cd $(SRC) && \
	$(MAKE) built
	for PKG in $($(SRC)_TSL_PKGS); do \
		cp $(PACKAGING_LOCATION)/$${PKG}/*.tpm.tar $(COLLECTING_DIR)/; \
	done
	> $@

$(SOURCE_PACKAGES:%=$(STATE_DIR)/%_clean_to_build): override SRC = $(patsubst %_clean_to_build,%,$(notdir $@))
$(SOURCE_PACKAGES:%=$(STATE_DIR)/%_clean_to_build): \
	$$(patsubst %,$(STATE_DIR)/%,$$($$(SRC)_SRC_CDEPS)) | $(STATE_DIR)
	cd $(SRC) && \
	$(MAKE) clean
	> $@


# Installing packages to the compiletime system
# Convenience Rule
.PHONY: $(ALL_TSL_PACKAGES:%=%_installed)
$(ALL_TSL_PACKAGES:%=%_installed): $(STATE_DIR)/$$@

$(ALL_TSL_PACKAGES:%=$(STATE_DIR)/%_installed): override PKG = $(patsubst %_installed,%,$(notdir $@))
$(ALL_TSL_PACKAGES:%=$(STATE_DIR)/%_installed): \
	$(STATE_DIR)/$$(PKG)_collected | $(TPM_CONF) /tmp $(STATE_DIR)
	# Reinstall is not needed because of microversioning
	$(TPM) --install $(PKG)
	$(TPM) --remove-unneeded
	> $@

# Special rule for gcc since a temporary symlink might have to be removed first
$(STATE_DIR)/gcc_installed: $(STATE_DIR)/gcc_symlinks_removed

$(STATE_DIR)/gcc_symlinks_removed: $(STATE_DIR)/gcc_collected $(STATE_DIR)/tool_links_created
	if test -L $(TPM_TARGET)/usr/lib/gcc; then rm $(TPM_TARGET)/usr/lib/gcc; fi
	rm -vf $(TPM_TARGET)/usr/lib/libstdc++.{a,so{,.$(libstdcxx_ABI)}} \
	rm -vf $(TPM_TARGET)/usr/lib/libgcc_s.so{,.$(libgcc_ABI)} \
	> $@

# Special rule for installing coreutils since the preliminary runtime system
# has some temporary symlinks which need to be removed no
$(STATE_DIR)/coreutils_installed: $(STATE_DIR)/coreutils_symlinks_removed
$(STATE_DIR)/coreutils-dev_installed: $(STATE_DIR)/coreutils_symlinks_removed

$(STATE_DIR)/coreutils_symlinks_removed: \
	$(STATE_DIR)/coreutils_collected \
	$(STATE_DIR)/tool_links_created
	if ! test -f $(STATE_DIR)/coreutils_installed; then \
		rm -vf $(TPM_TARGET)/usr/bin/install && \
		rm -vf $(TPM_TARGET)/bin/{cat,dd,echo,ln,pwd,rm,stty}; \
	fi
	> $@

# Special rule for installing bash since a symlink needs to be removed first
$(STATE_DIR)/bash_installed: $(STATE_DIR)/bash_symlinks_removed
$(STATE_DIR)/bash-dev_installed: $(STATE_DIR)/bash_symlinks_removed

$(STATE_DIR)/bash_symlinks_removed: \
	$(STATE_DIR)/bash_collected \
	$(STATE_DIR)/tool_links_created
	if ! test -f $(STATE_DIR)/bash_installed; then rm $(TPM_TARGET)/bin/bash; fi
	> $@


# Other rules
$(STATE_DIR)/toolchain_adjusted: adjust_toolchain.sh $(STATE_DIR)/glibc-dev_installed
	cd $(TOOLS_DIR) && \
	$(PACKAGING_RESOURCE_DIR)/adjust_toolchain.sh && \
	> $@

$(STATE_DIR)/tool_links_created: create_tool_links.sh
	cd $(TPM_TARGET) \
	&& $(PACKAGING_RESOURCE_DIR)/create_tool_links.sh && \
	> $@

$(TPM_CONF): $(MAKEFILE_LIST)
	install -dm755 $(dir $@)
	install -m 644 <(echo -e \
	"<?xml version=\"1.0\"?>\n\
	<tpm file_version=\"1.0\">\n\
	    <repo type=\"dir\">$(COLLECTING_REPO)</repo>\n\
	    <arch>$(PKG_ARCH)</arch>\n\
	</tpm>" || kill $$$$) $@

$(STATE_DIR)/dummy_pkgs_created: create_dummy_pkgs.sh
	bash $<
	> $@


# Creating directories
$(STATE_DIR):
	mkdir -p $@

$(COLLECTING_DIR):
	mkdir -p $@

/tmp:
	install -dm 1777 $@


# Utils
$(RM_OLD_PKG_VERSIONS): FORCE
	cd $(UTILS) && \
	$(MAKE)

# Cleaning
.PHONY: clean
clean: clean_collecting_repo clean_packages clean_compiletime_system clean_toolchain

# Cleaning and tidying up the collecting repo
.PHONY: remove_old_collected_packages
remove_old_collected_packages: $(RM_OLD_PKG_VERSIONS) | $(COLLECTING_DIR)
	@ echo
	@ echo This will remove all but the latest versions of each package from the
	@ echo $(PKG_ARCH)-branch of the collecting repo.
	@ echo
	@ echo Shall we proceed ? [y/N]
	@ read -n1 -s && test "$$REPLY" == "y"
	$(RM_OLD_PKG_VERSIONS) "$(COLLECTING_DIR)"

.PHONY: clean_collecting_repo
clean_collecting_repo: clean_collecting_repo_confirmation
	rm -vf $(COLLECTING_DIR)/*

.PHONY: clean_collecting_repo_confirmation
clean_collecting_repo_confirmation:
	@ echo
	@ echo The $(PKG_ARCH)-branch of the collecting repo will be cleaned completely.
	@ echo
	@ echo Shall we proceed ? [y/N]
	@ read -n1 -s && test "$$REPLY" == "y"

# Cleaning packages
.PHONY: clean_packages
clean_packages: $(SOURCE_PACKAGES:%=%_clean)

.PHONY: $(SOURCE_PACKAGES:%=%_clean)
$(SOURCE_PACKAGES:%=%_clean): override SRC = $(patsubst %_clean,%,$@)
$(SOURCE_PACKAGES:%=%_clean): clean_packages_confirmation
	cd $(SRC) && \
	$(MAKE) clean
	rm -vf $(STATE_DIR)/$(SRC)_built
	rm -vf $(patsubst %,$(STATE_DIR)/%_collected,$($(SRC)_TSL_PKGS))
	rm -vf $(STATE_DIR)/$(SRC)_clean_to_build

.PHONY: clean_packages_confirmation
clean_packages_confirmation:
	@ echo
	@ echo Packages will be cleaned
	@ echo
	@ echo Shall we proceed ? [y/N]
	@ read -n1 -s && test "$$REPLY" == "y"

# Cleaning the toolchain
.PHONY: clean_toolchain
clean_toolchain: clean_toolchain_confirmation
	cd $(TOOLS_DIR) && \
	$(PACKAGING_RESOURCE_DIR)/restore_toolchain.sh && \
	rm -vf $(STATE_DIR)/toolchain_adjusted

.PHONY: clean_toolchain_confirmation
clean_toolchain_confirmation:
	@ echo
	@ echo The toolchain will be cleaned
	@ echo
	@ echo Shall we proceed ? [y/N]
	@ read -n1 -s && test "$$REPLY" == "y"

# Cleaning the compiletime system
.PHONY: clean_compiletime_system
clean_compiletime_system: clean_compiletime_system_confirmation
	rm -rvf $(TPM_TARGET)/{bin,boot,etc,home,lib,lib64,media,mnt,opt,root,sbin,srv,tmp,usr,var}
	rm -vf $(STATE_DIR)/*_installed $(STATE_DIR)/*_symlinks_removed \
		$(STATE_DIR)/tool_links_created $(STATE_DIR)/dummy_pkgs_created

.PHONY: clean_compiletime_system_confirmation
clean_compiletime_system_confirmation:
	@ echo
	@ echo The entire compiletime system will be cleaned
	@ echo
	@ echo Shall we proceed ? [y/N]
	@ read -n1 -s && test "$$REPLY" == "y"


# Distributing the packaging files
.PHONY: dist
dist:
	rm -rf tslegacy_packaging-*.tar.xz
	rm -rf tslegacy_packaging-$(TSLPACK_VERSION)
	mkdir tslegacy_packaging-$(TSLPACK_VERSION)
	cp -a \
		Makefile \
		adjust_toolchain.sh \
		create_dummy_pkgs.sh \
		create_tool_links.sh \
		restore_toolchain.sh \
		set_env.sample \
		makefile_utilities.mk \
		show_todos.sh \
		common \
		skel \
		$(SOURCE_PACKAGES) \
		tslegacy_packaging-$(TSLPACK_VERSION)
	install -dm755 tslegacy_packaging-$(TSLPACK_VERSION)/utils
	cp -a \
		utils/{Makefile,remove_old_package_versions.ml,.gitignore,show_dynamic_dependencies.sh} \
		tslegacy_packaging-$(TSLPACK_VERSION)/utils
	tar -cJf tslegacy_packaging-$(TSLPACK_VERSION).tar.xz tslegacy_packaging-$(TSLPACK_VERSION)
	rm -rf tslegacy_packaging-$(TSLPACK_VERSION)

.PHONY: FORCE
FORCE:
