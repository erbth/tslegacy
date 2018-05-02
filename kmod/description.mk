ifndef kmod_description_included
kmod_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/zlib/description.mk

kmod_SRC_VERSION := 25
kmod_SRC_DIR := kmod-$(kmod_SRC_VERSION)
kmod_SRC_ARCHIVE := $(kmod_SRC_DIR).tar
kmod_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	zlib-dev_installed \
	glibc-dev_installed

export kmod_ABI := 2

kmod_TSL_TYPE := sw
kmod_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,zlib-$(zlib_ABI)) \
	$(call bigger_equal_dep,kmod-$(kmod_ABI)) \
	$(call bigger_equal_dep,licenses)
kmod_TSL_SRC_PKG := kmod

kmod-$(kmod_ABI)_TSL_TYPE := sw
kmod-$(kmod_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,zlib-$(zlib_ABI)) \
	$(call bigger_equal_dep,licenses)
kmod-$(kmod_ABI)_TSL_SRC_PKG := kmod

kmod-dev_TSL_TYPE := sw
kmod-dev_TSL_RDEPS = \
	$(call equal_dep,kmod-$(kmod_ABI)) \
	$(call equal_dep,kmod) \
	$(call bigger_equal_dep,licenses)
kmod-dev_TSL_SRC_PKG := kmod

kmod_TSL_PKGS := kmod-dev kmod-$(kmod_ABI) kmod

endif
