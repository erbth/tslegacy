ifndef mesa_description_included
mesa_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I got the important compiletime dependencies from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
mesa_SRC_VERSION := 18.1.0
mesa_SRC_DIR := mesa-$(mesa_SRC_VERSION)
mesa_SRC_ARCHIVE := $(mesa_SRC_DIR).tar.xz
mesa_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	llvm-dev_installed \
	xorg-libraries-dev_installed \
	libdrm-dev_installed \
	mako_installed \
	python-dev_installed \
	wayland-protocols_installed \
	wayland-dev_installed \
	icu-dev_installed \
	elfutils-dev_installed \
	expat-dev_installed \
	libffi-dev_installed \
	xz-dev_installed \
	zlib-dev_installed \
	libxcb-dev_installed \
	libxml2-dev_installed \
	ncurses-dev_installed

mesa_TSL_TYPE := sw
mesa_TSL_RDEPS =
mesa_TSL_SRC_PKG := mesa

mesa-dev_TSL_TYPE := sw
mesa-dev_TSL_RDEPS = \
	$(call equal_dep,mesa)
mesa-dev_TSL_SRC_PKG := mesa

mesa_TSL_PKGS := mesa-dev mesa

endif
