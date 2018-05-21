# Tab size: 4

# Information came from:
# https://stackoverflow.com/questions/7359527/removing-trailing-starting-newlines-with-sed-awk-tr-and-friends

SHELL := bash
TPM	?= tpm
M4 ?= m4
SED ?= sed
INSTALL ?= install
TAR ?= tar

# Options to Make
.SECONDEXPANSION:

# Makefile utilities
include ../makefile_utilities.mk

# Check the environment
ifndef PACKAGING_BASE
$(error PACKAGING_BASE not set)
endif

ifndef SOURCE_LOCATION
$(error SOURCE_LOCATION not set)
endif

export BUILD_LOCATION := $(PACKAGING_BASE)/build_location
export INSTALL_LOCATION := $(PACKAGING_BASE)/install_location
export PACKAGING_LOCATION := $(PACKAGING_BASE)/packaging_location

ifndef PKG_ARCH
$(error PKG_ARCH not set)
endif

ifndef $(SRC_NAME)_SRC_VERSION
$(error $(SRC_NAME)_SRC_VERSION not set)
endif
export SRC_VERSION := $($(SRC_NAME)_SRC_VERSION)

ifndef $(SRC_NAME)_SRC_ARCHIVE
$(error $(PKG_NAME)_SRC_ARCHIVE not set)
endif
SRC_ARCHIVE := $(SOURCE_LOCATION)/$($(SRC_NAME)_SRC_ARCHIVE)

ifndef $(SRC_NAME)_SRC_DIR
$(error $(SRC_NAME)_SRC_DIR not set)
endif
export SRC_DIR := $($(SRC_NAME)_SRC_DIR)

ifndef $(SRC_NAME)_TSL_PKGS
$(error $(SRC_NAME)_TSL_PKGS not set)
endif
export TSL_PKGS := $($(SRC_NAME)_TSL_PKGS)

# Automatically derived information
# export PACKAGING_RESOURCE_DIR := $(PWD)
export BUILD_DIR := $(BUILD_LOCATION)/$(SRC_NAME)
export INSTALL_DIR := $(INSTALL_LOCATION)/$(SRC_NAME)
PACKAGING_DIRS := $(TSL_PKGS:%=$(PACKAGING_LOCATION)/%)
PACKEDS := $(TSL_PKGS:%=$(PACKAGING_LOCATION)/%/packed)

pkg_of_pkg_dir = $(notdir $(call remove_trailing_slash,$(1)))

VERSIONS := $(TSL_PKGS:%=$(PACKAGING_LOCATION)/%/version)

# Config
DESCXML := desc.xml
export DESTDIR = destdir

ADAPT_SH := $(INSTALL_DIR)/adapt.sh
ADAPT_SH_IN := adapt.sh.in
ADAPT_M4 := ../common/adapt.m4

PATCH_SH := $(BUILD_DIR)/patch.sh
PATCH_SH_IN := patch.sh.in
PATCH_M4 := ../common/patch.m4

# Configure.sh and unconfigure.sh scripts
CONFIGURE_SH := configure.sh
CONFIGURESHS := $(foreach DIR,$(PACKAGING_DIRS),$(DIR)/configuresh)
CONFIGURE_M4 := ../common/configure.m4

UNCONFIGURE_SH := unconfigure.sh
UNCONFIGURESHS := $(foreach DIR,$(PACKAGING_DIRS),$(DIR)/unconfiguresh)
UNCONFIGURE_M4 := ../common/unconfigure.m4

# README files
readme_of_pkg_dir = $(call remove_trailing_slash,$(1))/$(DESTDIR)/usr/share/doc/$(call pkg_of_pkg_dir,$(1))/README.tslegacy
README_TSLEGACYS := $(foreach DIR,$(PACKAGING_DIRS),$(call readme_of_pkg_dir,$(DIR)))
in_of_readme = $(call pkg_of_pkg_dir,$(dir $(1)))_$(notdir $(1).in)
pkg_dir_of_readme = $(patsubst %/$(DESTDIR)/usr/share/doc/,%,$(dir $(call remove_trailing_slash,$(dir $(1)))))

README_TSLEGACY_M4 := ../common/README.tslegacy.m4

# Rules
.PHONY: no_target
no_target:

.PHONY: built
built: $(PACKEDS)

$(PACKEDS): override PKG_DIR = $(call remove_trailing_slash,$(dir $@))
$(PACKEDS): override PKG = $(call pkg_of_pkg_dir, $(PKG_DIR))
$(PACKEDS): \
	$(INSTALL_DIR)/installed_split \
	$$(PKG_DIR)/configuresh \
	$$(PKG_DIR)/unconfiguresh \
	$$(call readme_of_pkg_dir,$$(PKG_DIR)) \
	$(VERSIONS) \
	$$(PKG_DIR)/desc_initial \
	| $$(PKG_DIR)
	cd $(PKG_DIR) && \
	$(TPM) --set-name $(PKG) && \
	$(TPM) --set-version $(call read_version,$(PKG)) && \
	$(TPM) --set-arch $(PKG_ARCH) && \
	$(TPM) --remove-dependencies && \
	( for RDEP in $(foreach RDEP,$($(PKG)_TSL_RDEPS),"$(RDEP)"); do \
	$(TPM) --add-dependency "$$RDEP" || exit; done ) && \
	$(PACKAGING_RESOURCE_DIR)/common/auto_add_dependencies.sh $(PKG) && \
	rm -f *.tpm.tar && \
	$(TPM) --add-files && \
	$(TPM) --pack
	> $@

$(CONFIGURESHS): override PKG_DIR = $(call remove_trailing_slash,$(dir $@))
$(CONFIGURESHS): override PKG = $(call pkg_of_pkg_dir,$(PKG_DIR))
$(CONFIGURESHS): override CONFIGURE_IN = $(PKG)_$(CONFIGURE_SH).in
$(CONFIGURESHS): $$(wildcard $$(CONFIGURE_IN)) $(CONFIGURE_M4) \
	$$(PKG_DIR)/version \
	$(MAKEFILE_LIST) | $$(PKG_DIR)
	if [ "$<" == "$(CONFIGURE_IN)" ]; then \
		$(M4) \
			-D PKG_NAME=$(PKG) \
			-D PKG_VERSION=$(call read_version,$(PKG)) \
			-D PKG_UPSTREAM_VERSION=$(SRC_VERSION) \
			-D DATE_TODAY=$(call date_today) \
			$(CONFIGURE_M4) $(CONFIGURE_IN) \
		> $(PKG_DIR)/$(CONFIGURE_SH) && \
		$(SED) '/./,$$!d' -i $(PKG_DIR)/$(CONFIGURE_SH); \
	fi
	> $@

$(UNCONFIGURESHS): override PKG_DIR = $(call remove_trailing_slash,$(dir $@))
$(UNCONFIGURESHS): override PKG = $(call pkg_of_pkg_dir,$(PKG_DIR))
$(UNCONFIGURESHS): override UNCONFIGURE_IN = $(PKG)_$(UNCONFIGURE_SH).in
$(UNCONFIGURESHS): $$(wildcard $$(UNCONFIGURE_IN)) $(UNCONFIGURE_M4) \
	$$(PKG_DIR)/version \
	$(MAKEFILE_LIST) | $$(PKG_DIR)
	if [ "$<" == "$(UNCONFIGURE_IN)" ]; then \
		$(M4) \
			-D PKG_NAME=$(PKG) \
			-D PKG_VERSION=$(call read_version,$(PKG)) \
			-D PKG_UPSTREAM_VERSION=$(SRC_VERSION) \
			-D DATE_TODAY=$(call date_today) \
			$(UNCONFIGURE_M4) $(UNCONFIGURE_IN) \
		> $(PKG_DIR)/$(UNCONFIGURE_SH) && \
		$(SED) '/./,$$!d' -i $(PKG_DIR)/$(UNCONFIGURE_SH); \
	fi
	> $@

$(README_TSLEGACYS): override PKG_DIR = $(call pkg_dir_of_readme,$@)
$(README_TSLEGACYS): override PKG = $(call pkg_of_pkg_dir,$(PKG_DIR))
$(README_TSLEGACYS): override README_IN = $(call in_of_readme,$@)
$(README_TSLEGACYS): $$(README_IN) $(README_TSLEGACY_M4) \
	$$(PKG_DIR)/version \
	$(INSTALL_DIR)/installed_split \
	$(MAKEFILE_LIST) | $(PACKAGING_LOCATION)/$$(PKG)
	$(INSTALL) -dm755 $(dir $@)
	$(M4) \
		-D PKG_NAME=$(PKG) \
		-D PKG_VERSION=$(call read_version,$(PKG)) \
		-D PKG_UPSTREAM_VERSION=$(SRC_VERSION) \
		-D DATE_TODAY=$(call date_today) \
		$(README_TSLEGACY_M4) $< > $@
	$(SED) '/./,$$!d' -i $@
	chmod 644 $@


$(VERSIONS): override PKG_DIR = $(call remove_trailing_slash,$(dir $@))
$(VERSIONS): FORCE | $$(PKG_DIR)
	echo -n $$(date --utc +%Y.%j).$$(( $$(date --utc +%s) - \
	$$(date --utc -d 'today 00:00:00' +%s) )) > $@


$(INSTALL_DIR)/installed_split: \
	$(BUILD_DIR)/built \
	install_split.sh \
	$(TSL_PKGS:%=$(PACKAGING_LOCATION)/%/desc_initial) \
	$(INSTALL_DIR)/adaptsh \
	| $(INSTALL_DIR)
	./install_split.sh
	> $@

$(INSTALL_DIR)/adaptsh: $(wildcard $(ADAPT_SH_IN)) $(ADAPT_M4) $(MAKEFILE_LIST) | $(INSTALL_DIR)
	if [ "$<" == "$(ADAPT_SH_IN)" ]; then \
		$(M4) \
			-D PKG_NAME=$(PKG) \
			-D PKG_VERSION=$(call read_version,$(PKG)) \
			-D PKG_UPSTREAM_VERSION=$(SRC_VERSION) \
			-D DATE_TODAY=$(call date_today) \
			$(ADAPT_M4) $(ADAPT_SH_IN) \
			> $(ADAPT_SH) && \
		$(SED) '/./,$$!d' -i $(ADAPT_SH); \
	fi
	> $@


$(TSL_PKGS:%=$(PACKAGING_LOCATION)/%/desc_initial): \
	override TSL_PKG = $(patsubst $(PACKAGING_LOCATION)/%/desc_initial,%,$@)

$(TSL_PKGS:%=$(PACKAGING_LOCATION)/%/desc_initial): \
	$(MAKEFILE_LIST) | $(PACKAGING_LOCATION)/$$(TSL_PKG)
	cd $(PACKAGING_LOCATION)/$(TSL_PKG) && \
	if [ -e $(DESCXML) ]; then rm $(DESCXML); fi && \
	if [ -e $(DESTDIR) ]; then rm -r $(DESTDIR); fi && \
	$(TPM) --create-desc $($(TSL_PKG)_TSL_TYPE) && \
	> $@


$(BUILD_DIR)/built: $(BUILD_DIR)/configured | $(BUILD_DIR)

$(BUILD_DIR)/configured: $(BUILD_DIR)/patched | $(BUILD_DIR)

$(BUILD_DIR)/patched: $(BUILD_DIR)/patchsh $(BUILD_DIR)/source_ready | $(BUILD_DIR)
	if [ -f "$(PATCH_SH)" ]; then \
		cd $(BUILD_DIR)/$(SRC_DIR) && $(SHELL) $(PATCH_SH); \
	fi
	> $@

$(BUILD_DIR)/patchsh: $(wildcard $(PATCH_SH_IN)) $(PATCH_M4) $(MAKEFILE_LIST) | $(BUILD_DIR)
	if [ "$<" == "$(PATCH_SH_IN)" ]; then \
		$(M4) \
			-D PKG_NAME=$(PKG) \
			-D PKG_VERSION=$(call read_version,$(PKG)) \
			-D PKG_UPSTREAM_VERSION=$(SRC_VERSION) \
			-D DATE_TODAY=$(call date_today) \
			$(PATCH_M4) $(PATCH_SH_IN) \
			> $(PATCH_SH) && \
		$(SED) '/./,$$!d' -i $(PATCH_SH); \
	fi
	> $@

$(BUILD_DIR)/source_ready: $(MAKEFILE_LIST) $(SRC_ARCHIVE) | $(BUILD_DIR)
	if [ -n "$(CREATE_SRC_DIR)" ]; \
	then \
		install -dm755 $(BUILD_DIR)/$(SRC_DIR) && \
		$(TAR) -xf $(SRC_ARCHIVE) -C $(BUILD_DIR)/$(SRC_DIR); \
	else \
		$(TAR) -xf $(SRC_ARCHIVE) -C $(BUILD_DIR); \
	fi
	> $@

$(BUILD_DIR) $(INSTALL_DIR) $(TSL_PKGS:%=$(PACKAGING_LOCATION)/%):
	mkdir -p $@

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR) $(INSTALL_DIR) $(TSL_PKGS:%=$(PACKAGING_LOCATION)/%)

.PHONY: FORCE
FORCE:
