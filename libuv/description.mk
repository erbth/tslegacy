ifndef libuv_description_included
libuv_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

libuv_SRC_VERSION := 1.20.3
libuv_SRC_DIR := libuv-v$(libuv_SRC_VERSION)
libuv_SRC_ARCHIVE := $(libuv_SRC_DIR).tar.gz
libuv_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	libtool-dev_installed \
	autoconf-dev_installed \
	automake-dev_installed

export libuv_ABI := 1

libuv-$(libuv_ABI)_TSL_TYPE := sw
libuv-$(libuv_ABI)_TSL_RDEPS =
libuv-$(libuv_ABI)_TSL_SRC_PKG := libuv

libuv-dev_TSL_TYPE := sw
libuv-dev_TSL_RDEPS = \
	$(call equal_dep,libuv-$(libuv_ABI))
libuv-dev_TSL_SRC_PKG := libuv

libuv_TSL_PKGS := libuv-dev libuv-$(libuv_ABI)

endif
