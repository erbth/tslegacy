ifndef cifs-utils_description_included
cifs-utils_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

cifs-utils_SRC_VERSION := 6.8
cifs-utils_SRC_DIR := cifs-utils-$(cifs-utils_SRC_VERSION)
cifs-utils_SRC_ARCHIVE := $(cifs-utils_SRC_DIR).tar.bz2
cifs-utils_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	pkg-config-dev_installed

cifs-utils_TSL_TYPE := sw
cifs-utils_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
cifs-utils_TSL_SRC_PKG := cifs-utils

cifs-utils-dev_TSL_TYPE := sw
cifs-utils-dev_TSL_RDEPS = \
	$(call equal_dep,cifs-utils) \
	$(call bigger_equal_dep,licenses)
cifs-utils-dev_TSL_SRC_PKG := cifs-utils

cifs-utils_TSL_PKGS := cifs-utils-dev cifs-utils

endif
