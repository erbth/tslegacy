ifndef pcre_description_included
pcre_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

# I took the important compiletime dependencies from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
pcre_SRC_VERSION := 8.42
pcre_SRC_DIR := pcre-$(pcre_SRC_VERSION)
pcre_SRC_ARCHIVE := $(pcre_SRC_DIR).tar.bz2
pcre_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	zlib-dev_installed \
	bzip2-dev_installed \
	readline-dev_installed \
	ncurses-dev_installed

pcre-libs_TSL_TYPE := sw
pcre-libs_TSL_RDEPS =
pcre-libs_TSL_SRC_PKG := pcre

pcre_TSL_TYPE := sw
pcre_TSL_RDEPS = \
	$(call bigger_equal_dep,pcre-libs)
pcre_TSL_SRC_PKG := pcre

pcre-dev_TSL_TYPE := sw
pcre-dev_TSL_RDEPS = \
	$(call equal_dep,pcre-libs) \
	$(call equal_dep,pcre)
pcre-dev_TSL_SRC_PKG := pcre

pcre_TSL_PKGS := pcre-dev pcre pcre-libs

endif
