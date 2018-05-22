ifndef fontconfig_description_included
fontconfig_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I extracted the important compiletime dependencies from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
fontconfig_SRC_VERSION := 2.13.0
fontconfig_SRC_DIR := fontconfig-$(fontconfig_SRC_VERSION)
fontconfig_SRC_ARCHIVE := $(fontconfig_SRC_DIR).tar.bz2
fontconfig_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	freetype-dev_installed \
	libxml2-dev_installed \
	gperf-dev_installed \
	glib-dev_installed \
	harfbuzz-dev_installed \
	expat-dev_installed \
	libpng-dev_installed \
	util-linux-dev_installed \
	pcre-dev_installed \
	zlib-dev_installed \
	bzip2-dev_installed

fontconfig-libs_TSL_TYPE := sw
fontconfig-libs_TSL_RDEPS =
fontconfig-libs_TSL_SRC_PKG := fontconfig

fontconfig_TSL_TYPE := sw
fontconfig_TSL_RDEPS = \
	$(call bigger_equal_dep,fontconfig-libs)
fontconfig_TSL_SRC_PKG := fontconfig

fontconfig-dev_TSL_TYPE := sw
fontconfig-dev_TSL_RDEPS = \
	$(call equal_dep,fontconfig) \
	$(call equal_dep,fontconfig-libs)
fontconfig-dev_TSL_SRC_PKG := fontconfig

fontconfig_TSL_PKGS := fontconfig-dev fontconfig fontconfig-libs

endif
