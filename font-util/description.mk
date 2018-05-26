ifndef font-util_description_included
font-util_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I took the important compiletime dependencies from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
font-util_SRC_VERSION := 1.3.1
font-util_SRC_DIR := font-util-$(font-util_SRC_VERSION)
font-util_SRC_ARCHIVE := $(font-util_SRC_DIR).tar.bz2
font-util_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	libpng-dev_installed \
	mesa-dev_installed \
	xbitmaps_installed \
	libxcb-dev_installed \
	xcb-util-dev_installed \
	xorg-libraries-dev_installed

font-util_TSL_TYPE := sw
font-util_TSL_RDEPS =
font-util_TSL_SRC_PKG := font-util

font-util-dev_TSL_TYPE := sw
font-util-dev_TSL_RDEPS = \
	$(call bigger_equal_dep,font-util)
font-util-dev_TSL_SRC_PKG := font-util

font-util_TSL_PKGS := font-util-dev font-util

endif
