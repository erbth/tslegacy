ifndef xz_description_included
xz_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

xz_SRC_VERSION := 5.2.3
xz_SRC_DIR := xz-$(xz_SRC_VERSION)
xz_SRC_ARCHIVE := $(xz_SRC_DIR).tar.xz
xz_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	pkg-config-dev_installed

export liblzma_ABI := 5

liblzma-$(liblzma_ABI)_TSL_TYPE := sw
liblzma-$(liblzma_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
liblzma-$(liblzma_ABI)_TSL_SRC_PKG := xz

xz_TSL_TYPE := sw
xz_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,liblzma-$(liblzma_ABI)) \
	$(call bigger_equal_dep,licenses)
xz_TSL_SRC_PKG := xz

xz-dev_TSL_TYPE := sw
xz-dev_TSL_RDEPS = \
	$(call equal_dep,liblzma-$(liblzma_ABI)) \
	$(call equal_dep,xz) \
	$(call bigger_equal_dep,licenses)
xz-dev_TSL_SRC_PKG := xz

xz_TSL_PKGS := xz-dev xz liblzma-$(liblzma_ABI)

endif
