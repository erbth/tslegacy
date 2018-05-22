ifndef freetype_description_included
freetype_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# Important note: The dependency on HarfBuzz is managed in the master Makefile
# since this submodule cannot handle the cyclic dependency. Do not add harfbuzz
# here.
#
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
	glib-dev_installed \
	pcre-dev_installed \
	libpng-dev_installed \
	bzip2-dev_installed \
	zlib-dev_installed \
	pkg-config-dev_installed

freetype_TSL_TYPE := sw
freetype_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses)
freetype_TSL_SRC_PKG := freetype

freetype-dev_TSL_TYPE := sw
freetype-dev_TSL_RDEPS = \
	$(call equal_dep,freetype) \
	$(call bigger_equal_dep,licenses)
freetype-dev_TSL_SRC_PKG := freetype

freetype_TSL_PKGS := freetype-dev freetype

endif
