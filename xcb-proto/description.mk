ifndef xcb-proto_description_included
xcb-proto_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

xcb-proto_SRC_VERSION := 1.13
xcb-proto_SRC_DIR := xcb-proto-$(xcb-proto_SRC_VERSION)
xcb-proto_SRC_ARCHIVE := $(xcb-proto_SRC_DIR).tar.bz2
xcb-proto_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	python-dev_installed

xcb-proto-dev_TSL_TYPE := sw
xcb-proto-dev_TSL_RDEPS =
xcb-proto-dev_TSL_SRC_PKG := xcb-proto

xcb-proto_TSL_PKGS := xcb-proto-dev

endif
