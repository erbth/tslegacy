ifndef patch_description_included
patch_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

patch_SRC_VERSION := 2.7.6
patch_SRC_DIR := patch-$(patch_SRC_VERSION)
patch_SRC_ARCHIVE := $(patch_SRC_DIR).tar.xz
patch_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

patch-dev_TSL_TYPE := sw
patch-dev_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
patch-dev_TSL_SRC_PKG := patch

patch_TSL_PKGS := patch-dev

endif
