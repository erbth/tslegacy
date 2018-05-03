ifndef skel_description_included
skel_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/gcc/description.mk

skel_SRC_VERSION := 0.0.0
skel_SRC_DIR := skel-$(skel_SRC_VERSION)
skel_SRC_ARCHIVE := $(skel_SRC_DIR).tar.xz
skel_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

export skel_ABI := 10

skel-$(skel_ABI)_TSL_TYPE := sw
skel-$(skel_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI)) \
	$(call bigger_equal_dep,licenses)
skel-$(skel_ABI)_TSL_SRC_PKG := skel

skel-dev_TSL_TYPE := sw
skel-dev_TSL_RDEPS = \
	$(call equal_dep,skel-$(skel_ABI)) \
	$(call bigger_equal_dep,licenses)
skel-dev_TSL_SRC_PKG := skel

skel_TSL_PKGS := skel-dev skel-$(skel_ABI)

endif
