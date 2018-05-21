ifndef automake_description_included
automake_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

automake_SRC_VERSION := 1.16
automake_SRC_DIR := automake-$(automake_SRC_VERSION)
automake_SRC_ARCHIVE := $(automake_SRC_DIR).tar.xz
automake_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	autoconf-dev_installed

automake_TSL_TYPE := sw
automake_TSL_RDEPS = \
	$(call bigger_equal_dep,autoconf) \
	$(call bigger_equal_dep,licenses)
automake_TSL_SRC_PKG := automake

automake-dev_TSL_TYPE := sw
automake-dev_TSL_RDEPS = \
	$(call equal_dep,automake) \
	$(call bigger_equal_dep,licenses)
automake-dev_TSL_SRC_PKG := automake

automake_TSL_PKGS := automake-dev automake

endif
