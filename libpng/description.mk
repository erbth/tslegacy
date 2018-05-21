ifndef libpng_description_included
libpng_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

libpng_SRC_VERSION := 1.6.34
libpng_SRC_DIR := libpng-$(libpng_SRC_VERSION)
libpng_SRC_ARCHIVE := $(libpng_SRC_DIR).tar.xz
libpng_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	zlib-dev_installed

libpng-libs_TSL_TYPE := sw
libpng-libs_TSL_RDEPS =
libpng-libs_TSL_SRC_PKG := libpng

libpng_TSL_TYPE := sw
libpng_TSL_RDEPS = \
	$(call bigger_equal_dep,libpng-libs)
libpng_TSL_SRC_PKG := libpng

libpng-dev_TSL_TYPE := sw
libpng-dev_TSL_RDEPS = \
	$(call equal_dep,libpng) \
	$(call equal_dep,libpng-libs)
libpng-dev_TSL_SRC_PKG := libpng

libpng_TSL_PKGS := libpng-dev libpng-libs libpng

endif
