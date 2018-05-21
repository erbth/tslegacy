ifndef gperf_description_included
gperf_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

gperf_SRC_VERSION := 3.1
gperf_SRC_DIR := gperf-$(gperf_SRC_VERSION)
gperf_SRC_ARCHIVE := $(gperf_SRC_DIR).tar.gz
gperf_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

gperf_TSL_TYPE := sw
gperf_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses)
gperf_TSL_SRC_PKG := gperf

gperf-dev_TSL_TYPE := sw
gperf-dev_TSL_RDEPS = \
	$(call equal_dep,gperf) \
	$(call bigger_equal_dep,licenses)
gperf-dev_TSL_SRC_PKG := gperf

gperf_TSL_PKGS := gperf-dev gperf

endif
