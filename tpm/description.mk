ifndef tpm_description_included
tpm_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

tpm_SRC_VERSION := 1.0.4
tpm_SRC_DIR := tpm-$(tpm_SRC_VERSION)
tpm_SRC_ARCHIVE := $(tpm_SRC_DIR).tar.xz
tpm_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

tpm_TSL_TYPE := sw
tpm_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,coreutils) \
	$(call bigger_equal_dep,gzip) \
	$(call bigger_equal_dep,tar) \
	$(call bigger_equal_dep,licenses)
tpm_TSL_SRC_PKG := tpm


tpm_TSL_PKGS := tpm

endif