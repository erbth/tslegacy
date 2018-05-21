ifndef ninja_description_included
ninja_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

ninja_SRC_VERSION := 1.8.2
ninja_SRC_DIR := ninja-$(ninja_SRC_VERSION)
ninja_SRC_ARCHIVE := $(ninja_SRC_DIR).tar.gz
ninja_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	python3-dev_installed

ninja_TSL_TYPE := sw
ninja_TSL_RDEPS =
ninja_TSL_SRC_PKG := ninja

ninja_TSL_PKGS := ninja

endif
