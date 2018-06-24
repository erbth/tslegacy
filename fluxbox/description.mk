ifndef fluxbox_description_included
fluxbox_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I took the important compiletime dependencies from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team and added others, some of which I discovered after the build.
# At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
fluxbox_SRC_VERSION := 1.3.7
fluxbox_SRC_DIR := fluxbox-$(fluxbox_SRC_VERSION)
fluxbox_SRC_ARCHIVE := $(fluxbox_SRC_DIR).tar.xz
fluxbox_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	xorg-libraries-dev_installed \
	fribidi-dev_installed

fluxbox_TSL_TYPE := sw
fluxbox_TSL_RDEPS = \
	$(call bigger_equal_dep,xmessage)
fluxbox_TSL_SRC_PKG := fluxbox

fluxbox-dev_TSL_TYPE := sw
fluxbox-dev_TSL_RDEPS = \
	$(call equal_dep,fluxbox)
fluxbox-dev_TSL_SRC_PKG := fluxbox

fluxbox_TSL_PKGS := fluxbox-dev fluxbox

endif
