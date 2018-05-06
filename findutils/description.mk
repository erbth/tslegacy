ifndef findutils_description_included
findutils_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

findutils_SRC_VERSION := 4.6.0
findutils_SRC_DIR := findutils-$(findutils_SRC_VERSION)
findutils_SRC_ARCHIVE := $(findutils_SRC_DIR).tar.gz
findutils_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

findutils_TSL_TYPE := sw
findutils_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
findutils_TSL_SRC_PKG := findutils

findutils-dev_TSL_TYPE := sw
findutils-dev_TSL_RDEPS = \
	$(call equal_dep,findutils) \
	$(call bigger_equal_dep,licenses)
findutils-dev_TSL_SRC_PKG := findutils

findutils_TSL_PKGS := findutils-dev findutils

endif
