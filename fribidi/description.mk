ifndef fribidi_description_included
fribidi_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I took the compiletime dependency GLib from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
fribidi_SRC_VERSION := 1.0.3
fribidi_SRC_DIR := fribidi-$(fribidi_SRC_VERSION)
fribidi_SRC_ARCHIVE := $(fribidi_SRC_DIR).tar.bz2
fribidi_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	glib-dev_installed

fribidi-libs_TSL_TYPE := sw
fribidi-libs_TSL_RDEPS =
fribidi-libs_TSL_SRC_PKG := fribidi

fribidi_TSL_TYPE := sw
fribidi_TSL_RDEPS = \
	$(call bigger_equal_dep,fribidi-libs)
fribidi_TSL_SRC_PKG := fribidi

fribidi-dev_TSL_TYPE := sw
fribidi-dev_TSL_RDEPS = \
	$(call equal_dep,fribidi-libs) \
	$(call equal_dep,fribidi)
fribidi-dev_TSL_SRC_PKG := fribidi

fribidi_TSL_PKGS := fribidi-dev fribidi-libs fribidi

endif
