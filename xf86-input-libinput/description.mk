ifndef xf86-input-libinput_description_included
xf86-input-libinput_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I took the important compiletime dependencies from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
xf86-input-libinput_SRC_VERSION := 0.27.1
xf86-input-libinput_SRC_DIR := xf86-input-libinput-$(xf86-input-libinput_SRC_VERSION)
xf86-input-libinput_SRC_ARCHIVE := $(xf86-input-libinput_SRC_DIR).tar.bz2
xf86-input-libinput_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	libinput-dev_installed \
	xorg-server-dev_installed

xf86-input-libinput_TSL_TYPE := sw
xf86-input-libinput_TSL_RDEPS =
xf86-input-libinput_TSL_SRC_PKG := xf86-input-libinput

xf86-input-libinput-dev_TSL_TYPE := sw
xf86-input-libinput-dev_TSL_RDEPS = \
	$(call equal_dep,xf86-input-libinput)
xf86-input-libinput-dev_TSL_SRC_PKG := xf86-input-libinput

xf86-input-libinput_TSL_PKGS := xf86-input-libinput-dev xf86-input-libinput

endif
