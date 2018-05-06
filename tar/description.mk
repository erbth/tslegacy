ifndef tar_description_included
tar_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

tar_SRC_VERSION := 1.30
tar_SRC_DIR := tar-$(tar_SRC_VERSION)
tar_SRC_ARCHIVE := $(tar_SRC_DIR).tar.xz
tar_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

tar_TSL_TYPE := sw
tar_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
tar_TSL_SRC_PKG := tar

tar-dev_TSL_TYPE := sw
tar-dev_TSL_RDEPS = \
	$(call equal_dep,tar) \
	$(call bigger_equal_dep,licenses)
tar-dev_TSL_SRC_PKG := tar

tar_TSL_PKGS := tar-dev tar

endif
