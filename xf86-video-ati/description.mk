ifndef xf86-video-ati_description_included
xf86-video-ati_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I took the important compiletime dependencies from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team and added others, some of which I discovered after the build.
# At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
xf86-video-ati_SRC_VERSION := 18.0.1
xf86-video-ati_SRC_DIR := xf86-video-ati-$(xf86-video-ati_SRC_VERSION)
xf86-video-ati_SRC_ARCHIVE := $(xf86-video-ati_SRC_DIR).tar.bz2
xf86-video-ati_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	xorg-server-dev_installed

xf86-video-ati_TSL_TYPE := sw
xf86-video-ati_TSL_RDEPS =
xf86-video-ati_TSL_SRC_PKG := xf86-video-ati

xf86-video-ati-dev_TSL_TYPE := sw
xf86-video-ati-dev_TSL_RDEPS = \
	$(call equal_dep,xf86-video-ati)
xf86-video-ati-dev_TSL_SRC_PKG := xf86-video-ati

xf86-video-ati_TSL_PKGS := xf86-video-ati-dev xf86-video-ati

endif
