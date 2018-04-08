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
PKG_NAME := isc-dhcp-client
# The version must consist of exactly three parts
PKG_VERSION := 4.4.1

ifndef PKG_ARCH
$(error PKG_ARCH not set)
endif

PKG_RDEPS := glibc
SOURCE_ARCHIVE := dhcp-$(PKG_VERSION).tar.gz

# Automatically derived information - shall be adapted if required
# This may need to be adapted
export SOURCE_DIR := $(SOURCE_ARCHIVE:%.tar.gz=%)
SOURCE_ARCHIVE := $(SOURCE_LOCATION)/$(SOURCE_ARCHIVE)
PKG_BUILD_LOCATION := $(BUILD_LOCATION)/$(PKG_NAME)
export WORKING_DIR := $(PKG_BUILD_LOCATION)/$(PKG_ARCH)
PACKED := $(PKG_NAME)_$(PKG_ARCH).tpm.tar
export PACKAGING_RESOURCE_DIR := $(PWD)

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

# I read in BLFS 8.2 that the client and the script can be installed that way.
installed: built desc_initial
	cd $(WORKING_DIR)/$(SOURCE_DIR)/client && \
	$(MAKE) -j 1 DESTDIR=$(WORKING_DIR)/$(DESTDIR) install-strip && \
	install -v -dm755 "$(WORKING_DIR)/$(DESTDIR)"/sbin && \
	install -v -m755 scripts/linux "$(WORKING_DIR)/$(DESTDIR)"/sbin/dhclient-script && \
	> $(PWD)/$@

# BLFS 8.2 suggests to build single threaded
built: configured
	cd $(WORKING_DIR)/$(SOURCE_DIR)&& $(MAKE) -j 1 && > $(PWD)/built

# I took this configure procedure from BLFS 8.2. It looks like if it increases
# FHS compatibility, which is a good thing.
configured: patched
	cd $(WORKING_DIR)/$(SOURCE_DIR) && \
	CFLAGS="-D_PATH_DHCLIENT_SCRIPT='\"/sbin/dhclient-script\"' \
			-D_PATH_DHCPD_CONF='\"/etc/dhcp/dhcpd.conf\"' \
			-D_PATH_DHCLIENT_CONF='\"/etc/dhcp/dhclient.conf\"'" && \
	./configure --prefix=/usr \
		--sysconfdir=/etc/dhcp \
		--localstatedir=/var \
		--with-srv-lease-file=/var/lib/dhcpd/dhcpd.leases \
		--with-srv6-lease-file=/var/lib/dhcpd/dhcpd6.leases \
		--with-cli-lease-file=/var/lib/dhclient/dhclient.leases \
		--with-cli6-lease-file=/var/lib/dhclient/dhclient6.leases && \
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
