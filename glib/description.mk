ifndef glib_description_included
glib_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I got the depednency on PCRE from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
glib_SRC_VERSION := 2.56.1
glib_SRC_DIR := glib-$(glib_SRC_VERSION)
glib_SRC_ARCHIVE := $(glib_SRC_DIR).tar.xz
glib_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	ninja_installed \
	meson_installed \
	pcre-dev_installed

glib-libs_TSL_TYPE := sw
glib-libs_TSL_RDEPS =
glib-libs_TSL_SRC_PKG := glib

glib_TSL_TYPE := sw
glib_TSL_RDEPS = \
	$(call bigger_equal_dep,glib-libs)
glib_TSL_SRC_PKG := glib

glib-dev_TSL_TYPE := sw
glib-dev_TSL_RDEPS = \
	$(call equal_dep,glib) \
	$(call equal_dep,glib-libs)
glib-dev_TSL_SRC_PKG := glib

glib_TSL_PKGS := glib-dev glib glib-libs

endif
