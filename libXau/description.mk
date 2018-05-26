ifndef libXau_description_included
libXau_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/gcc/description.mk

libXau_SRC_VERSION := 1.0.8
libXau_SRC_DIR := libXau-$(libXau_SRC_VERSION)
libXau_SRC_ARCHIVE := $(libXau_SRC_DIR).tar.bz2
libXau_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	xorgproto_installed

libXau_TSL_TYPE := sw
libXau_TSL_RDEPS =
libXau_TSL_SRC_PKG := libXau

libXau-dev_TSL_TYPE := sw
libXau-dev_TSL_RDEPS = \
	$(call equal_dep,libXau)
libXau-dev_TSL_SRC_PKG := libXau

libXau_TSL_PKGS := libXau-dev libXau

endif
