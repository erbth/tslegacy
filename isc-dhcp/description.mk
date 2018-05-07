ifndef isc-dhcp_description_included
isc-dhcp_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

isc-dhcp_SRC_VERSION := 4.4.1
isc-dhcp_SRC_DIR := dhcp-$(isc-dhcp_SRC_VERSION)
isc-dhcp_SRC_ARCHIVE := $(isc-dhcp_SRC_DIR).tar.gz
isc-dhcp_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	bash-dev_installed \
	coreutils-dev_installed

isc-dhcp-client_TSL_TYPE := sw
isc-dhcp-client_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,bash) \
	$(call bigger_equal_dep,coreutils) \
	$(call bigger_equal_dep,licenses)
isc-dhcp-client_TSL_SRC_PKG := isc-dhcp

isc-dhcp-dev_TSL_TYPE := sw
isc-dhcp-dev_TSL_RDEPS = \
	$(call equal_dep,isc-dhcp-client) \
	$(call bigger_equal_dep,licenses)
isc-dhcp-dev_TSL_SRC_PKG := isc-dhcp

isc-dhcp_TSL_PKGS := isc-dhcp-dev isc-dhcp-client

endif
