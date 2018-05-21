ifndef libxcb_description_included
libxcb_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/gcc/description.mk

libxcb_SRC_VERSION := 1.13
libxcb_SRC_DIR := libxcb-$(libxcb_SRC_VERSION)
libxcb_SRC_ARCHIVE := $(libxcb_SRC_DIR).tar.bz2
libxcb_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	libXau-dev_installed \
	libXdmcp-dev_installed \
	xcb-proto-dev_installed

libxcb_TSL_TYPE := sw
libxcb_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI)) \
	$(call bigger_equal_dep,licenses)
libxcb_TSL_SRC_PKG := libxcb

libxcb-dev_TSL_TYPE := sw
libxcb-dev_TSL_RDEPS = \
	$(call equal_dep,libxcb) \
	$(call bigger_equal_dep,licenses)
libxcb-dev_TSL_SRC_PKG := libxcb

libxcb_TSL_PKGS := libxcb-dev libxcb

endif
