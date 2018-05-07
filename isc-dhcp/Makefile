SRC_NAME := isc-dhcp

include description.mk
include ../common/basic.mk

# I adapted the configure and build procedures from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.

# These configure parameters are from BLFS 8.2. It looks like if they increase
# FHS compatibility, which is a good thing.
$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	CFLAGS="-D_PATH_DHCLIENT_SCRIPT='\"/sbin/dhclient-script\"' \
			-D_PATH_DHCPD_CONF='\"/etc/dhcp/dhcpd.conf\"' \
			-D_PATH_DHCLIENT_CONF='\"/etc/dhcp/dhclient.conf\"'" && \
	./configure --prefix=/usr \
		--sysconfdir=/etc/dhcp \
		--localstatedir=/var \
		--with-srv-lease-file=/var/lib/dhcpd/dhcpd.leases \
		--with-srv6-lease-file=/var/lib/dhcpd/dhcpd6.leases \
		--with-cli-lease-file=/var/lib/dhclient/dhclient.leases \
		--with-cli6-lease-file=/var/lib/dhclient/dhclient6.leases
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	$(MAKE) -j1
	> $@