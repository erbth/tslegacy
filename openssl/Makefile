# Tab size: 4
# The compilation and installation procedure was adapted from LFS 8.2, p. 167
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
PKG_NAME := openssl
# The version must consist of exactly three parts
# $upstream version X.Y.Zm \mapsto X.Y.(Z * 100 + index_in_alphabet(m))$
# This is the upstream version 1.1.0h
PKG_VERSION := 1.1.8

ifndef PKG_ARCH
$(error PKG_ARCH not set)
endif

PKG_RDEPS := glibc zlib linux
SOURCE_ARCHIVE := $(PKG_NAME)-1.1.0h.tar.gz

# Automatically derived information - shall be adapted if required
# This may need to be adapted
SOURCE_DIR := $(SOURCE_ARCHIVE:%.tar.gz=%)
SOURCE_ARCHIVE := $(SOURCE_LOCATION)/$(SOURCE_ARCHIVE)
PKG_BUILD_LOCATION := $(BUILD_LOCATION)/$(PKG_NAME)
export WORKING_DIR := $(PKG_BUILD_LOCATION)/$(PKG_ARCH)
PACKED := $(PKG_NAME)_$(PKG_ARCH).tpm.tar

# config
POSTINSTSH := postinst.sh
PRERMSH := prerm.sh
PREUPDATESH := preupdate.sh
ADAPTSH := adapt.sh
PATCHSH := patch.sh
DESCXML := desc.xml
export DESTDIR = destdir

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
	sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile && \
	$(MAKE) DESTDIR=$(WORKING_DIR)/$(DESTDIR) \
	MANSUFFIX=ssl install && \
	> $(PWD)/$@

built: configured
	cd $(WORKING_DIR)/$(SOURCE_DIR) && $(MAKE) && \
	> $(PWD)/$@

configured: patched
	cd $(WORKING_DIR)/$(SOURCE_DIR) && \
	./config --prefix=/usr \
		--openssldir=/etc/ssl \
		--libdir=lib \
		shared \
		zlib-dynamic && \
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
