ifndef xcursor-themes_description_included
xcursor-themes_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I took the dependency on xorg applications from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
xcursor-themes_SRC_VERSION := 1.0.5
xcursor-themes_SRC_DIR := xcursor-themes-$(xcursor-themes_SRC_VERSION)
xcursor-themes_SRC_ARCHIVE := $(xcursor-themes_SRC_DIR).tar.bz2
xcursor-themes_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	xorg-applications-dev_installed

xcursor-themes_TSL_TYPE := sw
xcursor-themes_TSL_RDEPS =
xcursor-themes_TSL_SRC_PKG := xcursor-themes

xcursor-themes_TSL_PKGS := xcursor-themes

endif
