ifndef wayland_description_included
wayland_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I got the dependency on libxml2 from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
wayland_SRC_VERSION := 1.15.0
wayland_SRC_DIR := wayland-$(wayland_SRC_VERSION)
wayland_SRC_ARCHIVE := $(wayland_SRC_DIR).tar.xz
wayland_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	libxml2-dev_installed \
	libffi-dev_installed \
	icu-dev_installed \
	expat-dev_installed \
	xz-dev_installed \
	zlib-dev_installed

wayland_TSL_TYPE := sw
wayland_TSL_RDEPS =
wayland_TSL_SRC_PKG := wayland

wayland-dev_TSL_TYPE := sw
wayland-dev_TSL_RDEPS = \
	$(call equal_dep,wayland)
wayland-dev_TSL_SRC_PKG := wayland

wayland_TSL_PKGS := wayland-dev wayland

endif
