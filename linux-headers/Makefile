# Tab size: 4
SHELL := bash
TPM	?= tpm
TAR ?= tar

ifndef BUILD_LOCATION
$(error BUILD_LOCATION not set)
endif

ifndef SOURCE_LOCATION
$(error SOURCE_LOCATION not set)
endif

# Package information:
PKG_TYPE := sw
PKG_NAME := linux-headers
# The version must consist of exactly three parts
PKG_VERSION := 4.15.15

ifndef PKG_ARCH
$(error PKG_ARCH not set)
endif

PKG_RDEPS :=
SOURCE_ARCHIVE := linux-$(PKG_VERSION).tar

# Automatically derived information - shall be adapted if required
# This may need to be adapted
SOURCE_DIR := $(SOURCE_ARCHIVE:%.tar=%)
SOURCE_ARCHIVE := $(SOURCE_LOCATION)/$(SOURCE_ARCHIVE)
PKG_BUILD_LOCATION := $(BUILD_LOCATION)/$(PKG_NAME)
WORKING_DIR := $(PKG_BUILD_LOCATION)/$(PKG_ARCH)
PACKED := $(PKG_NAME)_$(PKG_ARCH).tpm.tar

# config
POSTINSTSH := postinst.sh
PRERMSH := prerm.sh
PREUPDATESH := preupdate.sh
ADAPTSH := adapt.sh
PATCHSH := patch.sh
DESCXML := desc.xml
DESTDIR = destdir

$(WORKING_DIR)/$(PACKED): adapted desc_final postinstsh prermsh preupdatesh
	cd $(WORKING_DIR) && $(TPM) --pack

postinstsh: $(wildcard $(POSTINSTSH)) | $(WORKING_DIR)
	if [ -n "$<" ]; then cp "$<" $(WORKING_DIR); fi && > $@

prermsh: $(wildcard $(PRERMSH)) | $(WORKING_DIR)
	if [ -n "$<" ]; then cp "$<" $(WORKING_DIR); fi && > $@

preupdatesh: $(wildcard $(PREUPDATESH)) | $(WORKING_DIR)
	if [ -n "$<" ]; then cp "$<" $(WORKING_DIR); fi && > $@

desc_final: desc_initial adapted
	cd $(WORKING_DIR) && \
	$(TPM) --set-name $(PKG_NAME) && \
	$(TPM) --set-version $(PKG_VERSION) && \
	$(TPM) --set-arch $(PKG_ARCH) && \
	( for RDEP in $(PKG_RDEPS); do $(TPM) --add-rdependency $$RDEP || exit; done ) && \
	$(TPM) --add-files && > $(PWD)/$@

desc_initial: Makefile | $(WORKING_DIR)
	cd $(WORKING_DIR) && \
	if [ -e $(DESCXML) ]; then rm $(DESCXML); fi && \
	if [ -e $(DESTDIR) ]; then rm -r $(DESTDIR); fi && \
	$(TPM) --create-desc $(PKG_TYPE) && > $(PWD)/$@

adapted: $(wildcard $(ADAPTSH)) installed
	if [ "$<" == "$(ADAPTSH)" ]; then \
	cd $(WORKING_DIR)/$(SOURCE_DIR) && $(PWD)/$(ADAPTSH); fi && > $(PWD)/$@

installed: built desc_initial
	cd $(WORKING_DIR)/$(SOURCE_DIR) && \
	install -dm755 $(WORKING_DIR)/$(DESTDIR)/usr/include && \
	cp -rv tmp_dest/include/* $(WORKING_DIR)/$(DESTDIR)/usr/include && \
	> $(PWD)/$@

built: patched
	cd $(WORKING_DIR)/$(SOURCE_DIR) && \
	rm -rvf tmp_dest && \
	$(MAKE) mrproper && \
	$(MAKE) INSTALL_HDR_PATH=tmp_dest headers_install && \
	find tmp_dest/include \( -name .install -o -name ..install.cmd \) -delete && \
	> $(PWD)/$@

patched: $(wildcard $(PATCHSH)) source_ready
	if [ "$<" == "$(PATCHSH)" ]; then \
	cd $(WORKING_DIR)/$(SOURCE_DIR) && $(PWD)/$(PATCHSH); fi && > $(PWD)/$@

source_ready: Makefile $(SOURCE_ARCHIVE) | $(WORKING_DIR)
	$(TAR) -xf $(SOURCE_ARCHIVE) -C $(WORKING_DIR) && > $(PWD)/$@

$(WORKING_DIR):
	mkdir -p $@

.PHONY: clean
clean:
	rm -rvf $(PKG_BUILD_LOCATION) source_ready patched configured built desc_initial \
	installed adapted desc_final postinstsh prermsh preupdatesh
