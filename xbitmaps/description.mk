ifndef xbitmaps_description_included
xbitmaps_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I took the important compiletime dependency util-macros from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
xbitmaps_SRC_VERSION := 1.1.2
xbitmaps_SRC_DIR := xbitmaps-$(xbitmaps_SRC_VERSION)
xbitmaps_SRC_ARCHIVE := $(xbitmaps_SRC_DIR).tar.bz2
xbitmaps_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	util-macros-dev_installed

xbitmaps_TSL_TYPE := sw
xbitmaps_TSL_RDEPS =
xbitmaps_TSL_SRC_PKG := xbitmaps

xbitmaps_TSL_PKGS := xbitmaps

endif
