ifndef libffi_description_included
libffi_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

libffi_SRC_VERSION := 3.2.1
libffi_SRC_DIR := libffi-$(libffi_SRC_VERSION)
libffi_SRC_ARCHIVE := $(libffi_SRC_DIR).tar.gz
libffi_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	pkg-config_installed

export libffi_ABI := 6

libffi-$(libffi_ABI)_TSL_TYPE := sw
libffi-$(libffi_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
libffi-$(libffi_ABI)_TSL_SRC_PKG := libffi

libffi-dev_TSL_TYPE := sw
libffi-dev_TSL_RDEPS = \
	$(call equal_dep,libffi-$(libffi_ABI))
libffi-dev_TSL_SRC_PKG := libffi

libffi_TSL_PKGS := libffi-dev libffi-$(libffi_ABI)

endif
