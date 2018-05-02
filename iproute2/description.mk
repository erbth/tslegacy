ifndef iproute2_description_included
iproute2_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

iproute2_SRC_VERSION := 4.16.0
iproute2_SRC_DIR := iproute2-$(iproute2_SRC_VERSION)
iproute2_SRC_ARCHIVE := $(iproute2_SRC_DIR).tar
iproute2_SRC_CDEPS := \
	licenses_installed \
	gcc_installed

iproute2_TSL_TYPE := sw
iproute2_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
iproute2_TSL_SRC_PKG := iproute2

iproute2-dev_TSL_TYPE := sw
iproute2-dev_TSL_RDEPS = \
	$(call equal_dep,iproute2) \
	$(call bigger_equal_dep,licenses)
iproute2-dev_TSL_SRC_PKG := iproute2

iproute2_TSL_PKGS := iproute2-dev iproute2

endif
