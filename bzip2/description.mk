ifndef bzip2_description_included
bzip2_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

bzip2_SRC_VERSION := 1.0.6
bzip2_SRC_DIR := bzip2-$(bzip2_SRC_VERSION)
bzip2_SRC_ARCHIVE := $(bzip2_SRC_DIR).tar.gz
bzip2_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed

export libbz2_ABI := 1.0

bzip2_TSL_TYPE := sw
bzip2_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
bzip2_TSL_SRC_PKG := bzip2

libbz2-$(libbz2_ABI)_TSL_TYPE := sw
libbz2-$(libbz2_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
libbz2-$(libbz2_ABI)_TSL_SRC_PKG := bzip2

bzip2-dev_TSL_TYPE := sw
bzip2-dev_TSL_RDEPS = \
	$(call equal_dep,bzip2) \
	$(call equal_dep,libbz2-$(libbz2_ABI))
bzip2-dev_TSL_SRC_PKG := bzip2

bzip2_TSL_PKGS := bzip2-dev bzip2 libbz2-$(libbz2_ABI)

endif
