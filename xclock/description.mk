ifndef xclock_description_included
xclock_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I took the important compiletime dependencies from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
xclock_SRC_VERSION := 1.0.7
xclock_SRC_DIR := xclock-$(xclock_SRC_VERSION)
xclock_SRC_ARCHIVE := $(xclock_SRC_DIR).tar.bz2
xclock_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	xorg-libraries-dev_installed

xclock_TSL_TYPE := sw
xclock_TSL_RDEPS =
xclock_TSL_SRC_PKG := xclock

xclock-dev_TSL_TYPE := sw
xclock-dev_TSL_RDEPS = \
	$(call equal_dep,xclock)
xclock-dev_TSL_SRC_PKG := xclock

xclock_TSL_PKGS := xclock-dev xclock

endif
