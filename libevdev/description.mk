ifndef libevdev_description_included
libevdev_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# The compiletime dependency on Python is listed optional in the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
libevdev_SRC_VERSION := 1.5.9
libevdev_SRC_DIR := libevdev-$(libevdev_SRC_VERSION)
libevdev_SRC_ARCHIVE := $(libevdev_SRC_DIR).tar.xz
libevdev_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	python-dev_installed

libevdev-libs_TSL_TYPE := sw
libevdev-libs_TSL_RDEPS =
libevdev-libs_TSL_SRC_PKG := libevdev

libevdev_TSL_TYPE := sw
libevdev_TSL_RDEPS = \
	$(call bigger_equal_dep,libevdev-libs)
libevdev_TSL_SRC_PKG := libevdev

libevdev-dev_TSL_TYPE := sw
libevdev-dev_TSL_RDEPS = \
	$(call equal_dep,libevdev) \
	$(call equal_dep,libevdev-libs)
libevdev-dev_TSL_SRC_PKG := libevdev

libevdev_TSL_PKGS := libevdev-dev libevdev libevdev-libs

endif
