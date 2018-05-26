ifndef xorg-server_description_included
xorg-server_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I took the important compiletime dependencies from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
xorg-server_SRC_VERSION := 1.20.0
xorg-server_SRC_DIR := xorg-server-$(xorg-server_SRC_VERSION)
xorg-server_SRC_ARCHIVE := $(xorg-server_SRC_DIR).tar.bz2
xorg-server_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	pixman-dev_installed \
	font-util-dev_installed \
	xorg-fonts_installed \
	xkeyboard-config-dev_installed \
	libepoxy-dev_installed \
	xcb-util-keysyms-dev_installed \
	xcb-util-image-dev_installed \
	xcb-util-renderutil-dev_installed \
	xcb-util-wm-dev_installed \
	wayland-dev_installed \
	wayland-protocols_installed

xorg-server_TSL_TYPE := sw
xorg-server_TSL_RDEPS =
xorg-server_TSL_SRC_PKG := xorg-server

xorg-server-dev_TSL_TYPE := sw
xorg-server-dev_TSL_RDEPS = \
	$(call equal_dep,xorg-server)
xorg-server-dev_TSL_SRC_PKG := xorg-server

xorg-server_TSL_PKGS := xorg-server-dev xorg-server

endif
