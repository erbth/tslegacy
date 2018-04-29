ifndef mpfr_description_included
mpfr_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/gmp/description.mk
include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

mpfr_SRC_VERSION := 4.0.1
mpfr_SRC_DIR := mpfr-$(mpfr_SRC_VERSION)
mpfr_SRC_ARCHIVE := $(mpfr_SRC_DIR).tar.xz
mpfr_SRC_CDEPS := gmp-dev_installed

export mpfr_ABI := 6

mpfr-$(mpfr_ABI)_TSL_TYPE := sw
mpfr-$(mpfr_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,gmp-$(gmp_ABI)) \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
mpfr-$(mpfr_ABI)_TSL_SRC_PKG := mpfr

mpfr-dev_TSL_TYPE := sw
mpfr-dev_TSL_RDEPS = \
	$(call equal_dep,mpfr-$(mpfr_ABI)) \
	$(call bigger_equal_dep,licenses)
mpfr-dev_TSL_SRC_PKG := mpfr

mpfr_TSL_PKGS := mpfr-$(mpfr_ABI) mpfr-dev

endif
