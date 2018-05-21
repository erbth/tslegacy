ifndef libtool_description_included
libtool_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

libtool_SRC_VERSION := 2.4.6
libtool_SRC_DIR := libtool-$(libtool_SRC_VERSION)
libtool_SRC_ARCHIVE := $(libtool_SRC_DIR).tar.xz
libtool_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

libtool_TSL_TYPE := sw
libtool_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses)
libtool_TSL_SRC_PKG := libtool

libtool-dev_TSL_TYPE := sw
libtool-dev_TSL_RDEPS = \
	$(call equal_dep,libtool) \
	$(call bigger_equal_dep,licenses)
libtool-dev_TSL_SRC_PKG := libtool

libtool_TSL_PKGS := libtool-dev libtool

endif
