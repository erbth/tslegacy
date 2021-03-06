ifndef libinput_description_included
libinput_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I got the compiletime dependencies mtdev and libevdev from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
libinput_SRC_VERSION := 1.10.901
libinput_SRC_DIR := libinput-$(libinput_SRC_VERSION)
libinput_SRC_ARCHIVE := $(libinput_SRC_DIR).tar.xz
libinput_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	libevdev-dev_installed \
	mtdev-dev_installed \
	eudev-dev_installed

libinput_TSL_TYPE := sw
libinput_TSL_RDEPS =
libinput_TSL_SRC_PKG := libinput

libinput-dev_TSL_TYPE := sw
libinput-dev_TSL_RDEPS = \
	$(call equal_dep,libinput)
libinput-dev_TSL_SRC_PKG := libinput

libinput_TSL_PKGS := libinput-dev libinput

endif
