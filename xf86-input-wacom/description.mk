ifndef xf86-input-wacom_description_included
xf86-input-wacom_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I took the important compiletime dependencies from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team and added others, some of which I discovered after the build.
# At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
xf86-input-wacom_SRC_VERSION := 0.36.0
xf86-input-wacom_SRC_DIR := xf86-input-wacom-$(xf86-input-wacom_SRC_VERSION)
xf86-input-wacom_SRC_ARCHIVE := $(xf86-input-wacom_SRC_DIR).tar.bz2
xf86-input-wacom_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	xorg-server-dev_installed \
	eudev-dev_installed

xf86-input-wacom_TSL_TYPE := sw
xf86-input-wacom_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses)
xf86-input-wacom_TSL_SRC_PKG := xf86-input-wacom

xf86-input-wacom-dev_TSL_TYPE := sw
xf86-input-wacom-dev_TSL_RDEPS = \
	$(call equal_dep,xf86-input-wacom) \
	$(call bigger_equal_dep,licenses)
xf86-input-wacom-dev_TSL_SRC_PKG := xf86-input-wacom

xf86-input-wacom_TSL_PKGS := xf86-input-wacom-dev xf86-input-wacom

endif
