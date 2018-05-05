ifndef elfutils_description_included
elfutils_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/gcc/description.mk
include $(PACKAGING_RESOURCE_DIR)/zlib/description.mk

elfutils_SRC_VERSION := 0.170
elfutils_SRC_DIR := elfutils-$(elfutils_SRC_VERSION)
elfutils_SRC_ARCHIVE := $(elfutils_SRC_DIR).tar.bz2
elfutils_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	zlib-dev_installed

export libasm_ABI := 1
export libdw_ABI := 1
export libelf_ABI := 1

libasm-$(libasm_ABI)_TSL_TYPE := sw
libasm-$(libasm_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI)) \
	$(call bigger_equal_dep,licenses)
libasm-$(libasm_ABI)_TSL_SRC_PKG := elfutils

libdw-$(libdw_ABI)_TSL_TYPE := sw
libdw-$(libdw_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI)) \
	$(call bigger_equal_dep,licenses)
libdw-$(libdw_ABI)_TSL_SRC_PKG := elfutils

libelf-$(libelf_ABI)_TSL_TYPE := sw
libelf-$(libelf_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI)) \
	$(call bigger_equal_dep,licenses)
libelf-$(libelf_ABI)_TSL_SRC_PKG := elfutils

elfutils_TSL_TYPE := sw
elfutils_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI)) \
	$(call bigger_equal_dep,licenses)
elfutils_TSL_SRC_PKG := elfutils

elfutils-dev_TSL_TYPE := sw
elfutils-dev_TSL_RDEPS = \
	$(call equal_dep,elfutils-$(elfutils_ABI)) \
	$(call bigger_equal_dep,licenses)
elfutils-dev_TSL_SRC_PKG := elfutils

elfutils_TSL_PKGS := \
	libasm-$(libasm_ABI) \
	libdw-$(libdw_ABI) \
	libelf-$(libelf_ABI) \
	elfutils \
	elfutils-dev

endif
