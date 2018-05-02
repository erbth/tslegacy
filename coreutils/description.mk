ifndef coreutils_description_included
coreutils_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/gmp/description.mk

coreutils_SRC_VERSION := 8.29
coreutils_SRC_DIR := coreutils-$(coreutils_SRC_VERSION)
coreutils_SRC_ARCHIVE := $(coreutils_SRC_DIR).tar.xz
coreutils_SRC_CDEPS := \
	licenses_installed \
	glibc-dev_installed \
	gmp-dev_installed

coreutils_TSL_TYPE := sw
coreutils_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,gmp-$(gmp_ABI)) \
	$(call bigger_equal_dep,licenses)
coreutils_TSL_SRC_PKG := coreutils

coreutils-dev_TSL_TYPE := sw
coreutils-dev_TSL_RDEPS = \
	$(call equal_dep,coreutils) \
	$(call bigger_equal_dep,licenses)
coreutils-dev_TSL_SRC_PKG := coreutils

coreutils_TSL_PKGS := coreutils-dev coreutils

endif
