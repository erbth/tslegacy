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
PKG_NAME := glibc
# The version must consist of exactly three parts
PKG_VERSION := 2.27.0

ifndef PKG_ARCH
$(error PKG_ARCH not set)
endif

PKG_RDEPS := linux
SOURCE_ARCHIVE := $(PKG_NAME)-2.27.tar.xz

# Automatically derived information - shall be adapted if required
SOURCE_DIR := $(SOURCE_ARCHIVE:%.tar.xz=%)	# This may need to be adapted
SOURCE_ARCHIVE := $(SOURCE_LOCATION)/$(SOURCE_ARCHIVE)
PKG_BUILD_LOCATION := $(BUILD_LOCATION)/$(PKG_NAME)-$(PKG_VERSION)
export WORKING_DIR := $(PKG_BUILD_LOCATION)/$(PKG_ARCH)
PACKED := $(PKG_NAME)-$(PKG_VERSION)_$(PKG_ARCH).tpm.tar

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
	cd $(WORKING_DIR)/$(SOURCE_DIR)/build && \
	touch etc/ld.so.conf && \
	sed '/test-installation/s@$$(PERL)@echo not running@' -i ../Makefile && \
	$(MAKE) DESTDIR=$(WORKING_DIR)/$(DESTDIR) install-strip && \
	> $(PWD)/$@

built: configured
	cd $(WORKING_DIR)/$(SOURCE_DIR)/build && $(MAKE) && > $(PWD)/built

configured: patched
	cd $(WORKING_DIR)/$(SOURCE_DIR) && \
	mkdir -pv build && cd build && \
	case $(uname -m) in \
		i?86)   GCC_INCDIR=/usr/lib/gcc/$(uname -m)-pc-linux-gnu/7.3.0/include;; \
		x86_64) GCC_INCDIR=/usr/lib/gcc/x86_64-pc-linux-gnu/7.3.0/include;; \
		*) false;; \
	esac && \
	eval CC="gcc -isystem $$GCC_INCDIR -isystem /usr/include" && \
	../configure \
		--prefix=/usr \
		--disable-werror \
		--enable-kernel=3.2 \
		--enable-stack-protector=strong \
		libc_cv_slibdir=/lib && \
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
