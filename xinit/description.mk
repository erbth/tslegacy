ifndef xinit_description_included
xinit_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I took the compiletime dependency on the xorg libraries from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
xinit_SRC_VERSION := 1.4.0
xinit_SRC_DIR := xinit-$(xinit_SRC_VERSION)
xinit_SRC_ARCHIVE := $(xinit_SRC_DIR).tar.bz2
xinit_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	xorg-libraries-dev_installed

xinit_TSL_TYPE := sw
xinit_TSL_RDEPS =
xinit_TSL_SRC_PKG := xinit

xinit-dev_TSL_TYPE := sw
xinit-dev_TSL_RDEPS = \
	$(call equal_dep,xinit)
xinit-dev_TSL_SRC_PKG := xinit

xinit_TSL_PKGS := xinit-dev xinit

endif
