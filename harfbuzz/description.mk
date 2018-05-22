ifndef harfbuzz_description_included
harfbuzz_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# Important note: The dependency on FreeType is handles in the master Makefile
# as the submodules of the packages do not have enough information to handle
# the cyclic dependency between HarfBuzz and FreeType.
#
# I extracted the important compiletime dependencies from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
harfbuzz_SRC_VERSION := 1.7.6
harfbuzz_SRC_DIR := harfbuzz-$(harfbuzz_SRC_VERSION)
harfbuzz_SRC_ARCHIVE := $(harfbuzz_SRC_DIR).tar.bz2
harfbuzz_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	icu-dev_installed \
	glib-dev_installed \
	bzip2-dev_installed \
	zlib-dev_installed \
	libpng-dev_installed \
	pcre-dev_installed \
	libffi-dev_installed

harfbuzz-libs_TSL_TYPE := sw
harfbuzz-libs_TSL_RDEPS =
harfbuzz-libs_TSL_SRC_PKG := harfbuzz

harfbuzz_TSL_TYPE := sw
harfbuzz_TSL_RDEPS = \
	$(call bigger_equal_dep,harfbuzz-libs)
harfbuzz_TSL_SRC_PKG := harfbuzz

harfbuzz-dev_TSL_TYPE := sw
harfbuzz-dev_TSL_RDEPS = \
	$(call equal_dep,harfbuzz) \
	$(call equal_dep,harfbuzz-libs)
harfbuzz-dev_TSL_SRC_PKG := harfbuzz

harfbuzz_TSL_PKGS := harfbuzz-dev harfbuzz harfbuzz-libs

endif
