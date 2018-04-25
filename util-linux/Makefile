# Tab size: 4

# For building the upstream package I adapted the process used in the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.

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
PKG_NAME := util-linux
# The version must consist of exactly three parts
PKG_VERSION := 2.32.0

ifndef PKG_ARCH
$(error PKG_ARCH not set)
endif

PKG_RDEPS := glibc ncurses eudev zlib
SOURCE_ARCHIVE := $(PKG_NAME)-2.32.tar

# Automatically derived information - shall be adapted if required
# This may need to be adapted
export SOURCE_DIR := $(SOURCE_ARCHIVE:%.tar=%)
SOURCE_ARCHIVE := $(SOURCE_LOCATION)/$(SOURCE_ARCHIVE)
PKG_BUILD_LOCATION := $(BUILD_LOCATION)/$(PKG_NAME)
export WORKING_DIR := $(PKG_BUILD_LOCATION)/$(PKG_ARCH)
PACKED := $(PKG_NAME)_$(PKG_ARCH).tpm.tar
export PACKAGING_RESOURCE_DIR := $(PWD)

# config
POSTINSTSH := postinst.sh
CONFIGURESH := configure.sh
PRERMSH := prerm.sh
PREUPDATESH := preupdate.sh
ADAPTSH := adapt.sh
PATCHSH := patch.sh
DESCXML := desc.xml
export DESTDIR = destdir

$(WORKING_DIR)/$(PACKED): adapted desc_final postinstsh configuresh prermsh preupdatesh
	cd $(WORKING_DIR) && $(TPM) --pack

postinstsh: $(wildcard $(POSTINSTSH)) | $(WORKING_DIR)
	if [ -n "$<" ]; then cp "$<" $(WORKING_DIR); fi && > $@

configuresh: $(wildcard $(CONFIGURESH)) | $(WORKING_DIR)
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
	$(MAKE) DESTDIR=$(WORKING_DIR)/$(DESTDIR) install-strip && \
	> $(PWD)/$@

built: configured
	cd $(WORKING_DIR)/$(SOURCE_DIR) && $(MAKE) && > $(PWD)/built

# The FHS version 3.0 requires the adjtime file to be located in
# /var/lib/hwclock
# The options passed to configure were taken from LFS 8.2, p. 208
configured: patched
	cd $(WORKING_DIR)/$(SOURCE_DIR) && \
	./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
		--prefix=/usr \
		--disable-chfn-chsh \
		--disable-login \
		--disable-nologin \
		--disable-su \
		--disable-setpriv \
		--disable-runuser \
		--disable-pylibmount \
		--disable-static \
		--without-python \
		--without-systemd \
		--without-systemdsystemunitdir && \
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