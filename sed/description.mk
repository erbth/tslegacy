ifndef sed_description_included
sed_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

sed_SRC_VERSION := 4.4
sed_SRC_DIR := sed-$(sed_SRC_VERSION)
sed_SRC_ARCHIVE := $(sed_SRC_DIR).tar.xz
sed_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

sed_TSL_TYPE := sw
sed_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
sed_TSL_SRC_PKG := sed

sed-dev_TSL_TYPE := sw
sed-dev_TSL_RDEPS = \
	$(call equal_dep,sed) \
	$(call bigger_equal_dep,licenses)
sed-dev_TSL_SRC_PKG := sed

sed_TSL_PKGS := sed-dev sed

endif
