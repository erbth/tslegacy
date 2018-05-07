ifndef talloc_description_included
talloc_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/python/description.mk

talloc_SRC_VERSION := 2.1.12
talloc_SRC_DIR := talloc-$(talloc_SRC_VERSION)
talloc_SRC_ARCHIVE := $(talloc_SRC_DIR).tar
talloc_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	python-dev_installed \
	pkg-config-dev_installed

export libpytalloc_util_ABI := 2
export libtalloc_ABI := 2

libpytalloc-util-$(libpytalloc_util_ABI)_TSL_TYPE := sw
libpytalloc-util-$(libpytalloc_util_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libpython-$(libpython_ABI)) \
	$(call bigger_equal_dep,libtalloc-$(libtalloc_ABI)) \
	$(call bigger_equal_dep,licenses)
libpytalloc-util-$(libpytalloc_util_ABI)_TSL_SRC_PKG := talloc

libtalloc-$(libtalloc_ABI)_TSL_TYPE := sw
libtalloc-$(libtalloc_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
libtalloc-$(libtalloc_ABI)_TSL_SRC_PKG := talloc

talloc-python_TSL_TYPE := sw
talloc-python_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libpytalloc-util-$(libpytalloc_util_ABI)) \
	$(call bigger_equal_dep,libtalloc-$(libtalloc_ABI)) \
	$(call bigger_equal_dep,libpython-$(libpython_ABI)) \
	$(call bigger_equal_dep,licenses)
talloc-python_TSL_SRC_PKG := talloc

talloc-dev_TSL_TYPE := sw
talloc-dev_TSL_RDEPS = \
	$(call equal_dep,libpytalloc-util-$(libpytalloc_util_ABI)) \
	$(call equal_dep,libtalloc-$(libtalloc_ABI)) \
	$(call equal_dep,talloc-python) \
	$(call bigger_equal_dep,licenses)
talloc-dev_TSL_SRC_PKG := talloc

talloc_TSL_PKGS := \
	libpytalloc-util-$(libpytalloc_util_ABI) \
	libtalloc-$(libtalloc_ABI) \
	talloc-python \
	talloc-dev

endif
