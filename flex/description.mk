ifndef flex_description_included
flex_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

flex_SRC_VERSION := 2.6.4
flex_SRC_DIR := flex-$(flex_SRC_VERSION)
flex_SRC_ARCHIVE := $(flex_SRC_DIR).tar.gz
flex_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed

flex-libs_TSL_TYPE := sw
flex-libs_TSL_RDEPS =
flex-libs_TSL_SRC_PKG := flex

flex_TSL_TYPE := sw
flex_TSL_RDEPS = \
	$(call bigger_equal_dep,flex-libs)
flex_TSL_SRC_PKG := flex

flex-dev_TSL_TYPE := sw
flex-dev_TSL_RDEPS = \
	$(call equal_dep,flex-libs) \
	$(call equal_dep,flex)
flex-dev_TSL_SRC_PKG := flex

flex_TSL_PKGS := flex-dev flex-libs flex

endif
