ifndef mtdev_description_included
mtdev_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

mtdev_SRC_VERSION := 1.1.5
mtdev_SRC_DIR := mtdev-$(mtdev_SRC_VERSION)
mtdev_SRC_ARCHIVE := $(mtdev_SRC_DIR).tar.bz2
mtdev_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

mtdev-libs_TSL_TYPE := sw
mtdev-libs_TSL_RDEPS =
mtdev-libs_TSL_SRC_PKG := mtdev

mtdev_TSL_TYPE := sw
mtdev_TSL_RDEPS = \
	$(call bigger_equal_dep,mtdev-libs)
mtdev_TSL_SRC_PKG := mtdev

mtdev-dev_TSL_TYPE := sw
mtdev-dev_TSL_RDEPS = \
	$(call equal_dep,mtdev) \
	$(call equal_dep,mtdev-libs)
mtdev-dev_TSL_SRC_PKG := mtdev

mtdev_TSL_PKGS := mtdev-dev mtdev mtdev-libs

endif
