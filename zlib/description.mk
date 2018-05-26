ifndef zlib_description_included
zlib_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

# Information about the source package itself
zlib_SRC_VERSION := 1.2.11
zlib_SRC_DIR := zlib-$(zlib_SRC_VERSION)
zlib_SRC_ARCHIVE := $(zlib_SRC_DIR).tar.gz
zlib_SRC_CDEPS := \
	glibc-dev_installed

export zlib_SRC_ABI_VERSION := 1
export zlib_ABI := $(zlib_SRC_ABI_VERSION)

# Information about the TSL packages that are crated out of this source package
zlib-dev_TSL_TYPE := sw
zlib-dev_TSL_RDEPS = \
	$(call equal_dep,zlib-$(zlib_SRC_ABI_VERSION)) \
	$(call bigger_equal_dep,licenses)
zlib-dev_TSL_SRC_PKG := zlib

zlib-$(zlib_SRC_ABI_VERSION)_TSL_TYPE := sw
zlib-$(zlib_SRC_ABI_VERSION)_RDEPS := \
	$(call bigger_equal_dep,glibc) \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
zlib-$(zlib_SRC_ABI_VERSION)_TSL_SRC_PKG := zlib

# A list of all packages that are created out of this source package
zlib_TSL_PKGS := zlib-dev zlib-$(zlib_SRC_ABI_VERSION)

endif
