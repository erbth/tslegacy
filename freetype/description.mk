ifndef freetype_description_included
freetype_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I extracted the important compiletime dependencies from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
freetype_SRC_VERSION := 2.9.1
freetype_SRC_DIR := freetype-$(freetype_SRC_VERSION)
freetype_SRC_ARCHIVE := $(freetype_SRC_DIR).tar.bz2
freetype_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	harfbuzz-dev_installed \
	libpng-dev_installed

freetype_TSL_TYPE := sw
freetype_TSL_RDEPS =
freetype_TSL_SRC_PKG := freetype

freetype-dev_TSL_TYPE := sw
freetype-dev_TSL_RDEPS = \
	$(call equal_dep,freetype)
freetype-dev_TSL_SRC_PKG := freetype

freetype_TSL_PKGS := freetype-dev freetype

endif
