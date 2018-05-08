# Tab size: 4

# For building the upstream package I adapted the process used in the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.

# For building the upstream package I adapted the process used in the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development Team.
# At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.

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
PKG_NAME := tslegacy-installer
# The version must consist of exactly three parts
PKG_VERSION := 1.0.0

ifndef PKG_ARCH
$(error PKG_ARCH not set)
endif

PKG_RDEPS := \
	tar gzip bash tpm coreutils libgcc libstdc++ tslegacy-sysconfig iana-etc \
	util-linux eudev grub vim tslegacy-utils kmod iproute2 kbd less procps-ng \
	shadow sysvinit tslegacy-bootscripts tzdata sed grep findutils e2fsprogs \
	cifs-utils linux

SOURCE_ARCHIVE := $(PKG_NAME)-$(PKG_VERSION).tar.xz

# Automatically derived information - shall be adapted if required
# This may need to be adapted
export SOURCE_DIR := $(SOURCE_ARCHIVE:%.tar.xz=%)
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

installed: README desc_initial
	cd $(WORKING_DIR)/$(DESTDIR) && \
	install -dm755 usr/share/doc/tslegacy-installer && \
	install -m644 $(PWD)/README usr/share/doc/tslegacy-installer/
	> $(PWD)/$@

README: README.in Makefile
	sed -e 's/PKG_NAME/$(PKG_NAME)/g' \
		-e 's/PKG_VERSION/$(PKG_VERSION)/g' \
		$< > $@

$(WORKING_DIR):
	mkdir -p $@

.PHONY: clean
clean:
	rm -rvf $(PKG_BUILD_LOCATION) source_ready patched configured built desc_initial \
	installed adapted desc_final postinstsh prermsh preupdatesh README
