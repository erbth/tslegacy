ifndef pixman_description_included
pixman_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I took the compiletime dependency on libpng from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
pixman_SRC_VERSION := 0.34.0
pixman_SRC_DIR := pixman-$(pixman_SRC_VERSION)
pixman_SRC_ARCHIVE := $(pixman_SRC_DIR).tar.gz
pixman_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	libpng-dev_installed

pixman_TSL_TYPE := sw
pixman_TSL_RDEPS =
pixman_TSL_SRC_PKG := pixman

pixman-dev_TSL_TYPE := sw
pixman-dev_TSL_RDEPS = \
	$(call equal_dep,pixman)
pixman-dev_TSL_SRC_PKG := pixman

pixman_TSL_PKGS := pixman-dev pixman

endif
