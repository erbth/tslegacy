ifndef binutils_description_included
binutils_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/zlib/description.mk
include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

binutils_SRC_VERSION := 2.30
binutils_SRC_DIR := binutils-$(binutils_SRC_VERSION)
binutils_SRC_ARCHIVE := $(binutils_SRC_DIR).tar.xz
binutils_SRC_CDEPS := toolchain_adjusted zlib-dev_installed

binutils_TSL_TYPE := sw
binutils_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc) \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,zlib-$(zlib_ABI)) \
	$(call bigger_equal_dep,licenses)
binutils_TSL_SRC_PKG := binutils

binutils_TSL_PKGS := binutils

endif
