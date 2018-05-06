ifndef tslegacy-utils_description_included
tslegacy-utils_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/util-linux/description.mk

tslegacy-utils_SRC_VERSION := 1.0.0
tslegacy-utils_SRC_DIR := tslegacy-utils-$(tslegacy-utils_SRC_VERSION)
tslegacy-utils_SRC_ARCHIVE := $(tslegacy-utils_SRC_DIR).tar.gz
tslegacy-utils_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	util-linux-dev_installed

tslegacy-utils_TSL_TYPE := sw
tslegacy-utils_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libmount-$(libmount_ABI)) \
	$(call bigger_equal_dep,libblkid-$(libblkid_ABI)) \
	$(call bigger_equal_dep,licenses)
tslegacy-utils_TSL_SRC_PKG := tslegacy-utils

tslegacy-utils-dev_TSL_TYPE := sw
tslegacy-utils-dev_TSL_RDEPS = \
	$(call equal_dep,tslegacy-utils) \
	$(call bigger_equal_dep,licenses)
tslegacy-utils-dev_TSL_SRC_PKG := tslegacy-utils

tslegacy-utils_TSL_PKGS := tslegacy-utils-dev tslegacy-utils

endif
