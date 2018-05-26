ifndef libepoxy_description_included
libepoxy_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I got the dependency on Mesa from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
libepoxy_SRC_VERSION := 1.5.2
libepoxy_SRC_DIR := libepoxy-$(libepoxy_SRC_VERSION)
libepoxy_SRC_ARCHIVE := $(libepoxy_SRC_DIR).tar.xz
libepoxy_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	mesa-dev_installed

libepoxy_TSL_TYPE := sw
libepoxy_TSL_RDEPS =
libepoxy_TSL_SRC_PKG := libepoxy

libepoxy-dev_TSL_TYPE := sw
libepoxy-dev_TSL_RDEPS = \
	$(call equal_dep,libepoxy)
libepoxy-dev_TSL_SRC_PKG := libepoxy

libepoxy_TSL_PKGS := libepoxy-dev libepoxy

endif
