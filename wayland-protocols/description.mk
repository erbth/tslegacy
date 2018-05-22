ifndef wayland-protocols_description_included
wayland-protocols_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I got the dependency on Wayland from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
wayland-protocols_SRC_VERSION := 1.14
wayland-protocols_SRC_DIR := wayland-protocols-$(wayland-protocols_SRC_VERSION)
wayland-protocols_SRC_ARCHIVE := $(wayland-protocols_SRC_DIR).tar.xz
wayland-protocols_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	wayland-dev_installed

wayland-protocols_TSL_TYPE := sw
wayland-protocols_TSL_RDEPS = \
	$(call bigger_equal_dep,wayland)
wayland-protocols_TSL_SRC_PKG := wayland-protocols

wayland-protocols_TSL_PKGS :=  wayland-protocols

endif
