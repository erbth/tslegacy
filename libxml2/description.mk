ifndef libxml2_description_included
libxml2_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

libxml2_SRC_VERSION := 2.9.8
libxml2_SRC_DIR := libxml2-$(libxml2_SRC_VERSION)
libxml2_SRC_ARCHIVE := $(libxml2_SRC_DIR).tar.gz
libxml2_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	python-dev_installed \
	icu-dev_installed \
	readline-dev_installed \
	ncurses-dev_installed \
	xz-dev_installed \
	zlib-dev_installed

libxml2-libs_TSL_TYPE := sw
libxml2-libs_TSL_RDEPS =
libxml2-libs_TSL_SRC_PKG := libxml2

libxml2_TSL_TYPE := sw
libxml2_TSL_RDEPS = \
	$(call bigger_equal_dep,libxml2-libs)
libxml2_TSL_SRC_PKG := libxml2

libxml2-dev_TSL_TYPE := sw
libxml2-dev_TSL_RDEPS = \
	$(call equal_dep,libxml2-libs) \
	$(call equal_dep,libxml2)
libxml2-dev_TSL_SRC_PKG := libxml2

libxml2_TSL_PKGS := libxml2-dev libxml2 libxml2-libs

endif
