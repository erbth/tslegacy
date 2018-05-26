ifndef xorgproto_description_included
xorgproto_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I got the compiletime dependency on util-macros from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
xorgproto_SRC_VERSION := 2018.4
xorgproto_SRC_DIR := xorgproto-$(xorgproto_SRC_VERSION)
xorgproto_SRC_ARCHIVE := $(xorgproto_SRC_DIR).tar.bz2
xorgproto_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	util-macros-dev_installed

xorgproto_TSL_TYPE := sw
xorgproto_TSL_RDEPS =
xorgproto_TSL_SRC_PKG := xorgproto

xorgproto_TSL_PKGS := xorgproto

endif
