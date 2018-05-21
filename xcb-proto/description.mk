ifndef xcb-proto-dev_description_included
xcb-proto-dev_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/gcc/description.mk

xcb-proto-dev_SRC_VERSION := 1.13
xcb-proto-dev_SRC_DIR := xcb-proto-dev-$(xcb-proto-dev_SRC_VERSION)
xcb-proto-dev_SRC_ARCHIVE := $(xcb-proto-dev_SRC_DIR).tar.bz2
xcb-proto-dev_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

xcb-proto-dev-dev_TSL_TYPE := sw
xcb-proto-dev-dev_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses)
xcb-proto-dev-dev_TSL_SRC_PKG := xcb-proto-dev

xcb-proto-dev_TSL_PKGS := xcb-proto-dev-dev)

endif
