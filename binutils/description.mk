include ../zlib/description.mk
include ../glibc/description.mk

binutils_SRC_VERSION := 2.30
binutils_SRC_DIR := binutils-$(binutils_SRC_VERSION)
binutils_SRC_ARCHIVE := $(binutils_SRC_DIR).tar.gz
binutils_SRC_CDEPS := toolchain_adjusted zlib-dev_installed

binutils_TSL_TYPE := sw
binutils_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc) \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,zlib-$(zlib_SRC_API_VERSION))
binutils_TSL_SRC_PKG := binutils

binutils_TSL_PKGS := binutils
