ifndef diffutils_description_included
diffutils_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

diffutils_SRC_VERSION := 3.6
diffutils_SRC_DIR := diffutils-$(diffutils_SRC_VERSION)
diffutils_SRC_ARCHIVE := $(diffutils_SRC_DIR).tar.xz
diffutils_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

diffutils-dev_TSL_TYPE := sw
diffutils-dev_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
diffutils-dev_TSL_SRC_PKG := diffutils

diffutils_TSL_PKGS := diffutils-dev

endif
