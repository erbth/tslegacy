ifndef eudev_description_included
eudev_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/util-linux/description.mk

eudev_SRC_VERSION := 3.2.5
eudev_SRC_DIR := eudev-$(eudev_SRC_VERSION)
eudev_SRC_ARCHIVE := $(eudev_SRC_DIR).tar.gz
eudev_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	pkg-config-dev_installed \
	dummy_pkgs_created \
	bash-dev_installed \
	coreutils-dev_installed \
	util-linux-dev_installed \
	kmod-dev_installed

export eudev_ABI := 1

eudev-$(eudev_ABI)_TSL_TYPE := sw
eudev-$(eudev_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
eudev-$(eudev_ABI)_TSL_SRC_PKG := eudev

eudev_TSL_TYPE := sw
eudev_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libblkid-$(libblkid_ABI)) \
	$(call bigger_equal_dep,eudev-$(eudev_ABI)) \
	$(call bigger_equal_dep,bash) \
	$(call bigger_equal_dep,coreutils) \
	$(call bigger_equal_dep,kmod) \
	$(call bigger_equal_dep,licenses)
eudev_TSL_SRC_PKG := eudev

eudev-dev_TSL_TYPE := sw
eudev-dev_TSL_RDEPS = \
	$(call equal_dep,eudev-$(eudev_ABI)) \
	$(call equal_dep,eudev) \
	$(call bigger_equal_dep,licenses)
eudev-dev_TSL_SRC_PKG := eudev

eudev_TSL_PKGS := eudev-dev eudev-$(eudev_ABI) eudev

endif
