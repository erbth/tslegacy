ifndef xf86-video-intel_description_included
xf86-video-intel_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I took the important compiletime dependencies from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
xf86-video-intel_SRC_VERSION := 20180512
xf86-video-intel_SRC_DIR := xf86-video-intel-$(xf86-video-intel_SRC_VERSION)
xf86-video-intel_SRC_ARCHIVE := $(xf86-video-intel_SRC_DIR).tar.bz2
xf86-video-intel_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	xorg-server-dev_installed

xf86-video-intel_TSL_TYPE := sw
xf86-video-intel_TSL_RDEPS =
xf86-video-intel_TSL_SRC_PKG := xf86-video-intel

xf86-video-intel-dev_TSL_TYPE := sw
xf86-video-intel-dev_TSL_RDEPS = \
	$(call equal_dep,xf86-video-intel)
xf86-video-intel-dev_TSL_SRC_PKG := xf86-video-intel

xf86-video-intel_TSL_PKGS := xf86-video-intel-dev xf86-video-intel

endif
