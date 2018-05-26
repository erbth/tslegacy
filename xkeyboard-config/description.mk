ifndef xkeyboard-config_description_included
xkeyboard-config_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I took the compiletime dependency on the xorg libraries from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
xkeyboard-config_SRC_VERSION := 2.23.1
xkeyboard-config_SRC_DIR := xkeyboard-config-$(xkeyboard-config_SRC_VERSION)
xkeyboard-config_SRC_ARCHIVE := $(xkeyboard-config_SRC_DIR).tar.bz2
xkeyboard-config_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	xorg-libraries-dev_installed

xkeyboard-config_TSL_TYPE := sw
xkeyboard-config_TSL_RDEPS =
xkeyboard-config_TSL_SRC_PKG := xkeyboard-config

xkeyboard-config-dev_TSL_TYPE := sw
xkeyboard-config-dev_TSL_RDEPS = \
	$(call equal_dep,xkeyboard-config)
xkeyboard-config-dev_TSL_SRC_PKG := xkeyboard-config

xkeyboard-config_TSL_PKGS := xkeyboard-config-dev xkeyboard-config

endif
