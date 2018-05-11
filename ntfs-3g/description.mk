ifndef ntfs-3g_description_included
ntfs-3g_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/util-linux/description.mk

ntfs-3g_SRC_VERSION := 2017.3.23
ntfs-3g_SRC_DIR := ntfs-3g_ntfsprogs-$(ntfs-3g_SRC_VERSION)
ntfs-3g_SRC_ARCHIVE := $(ntfs-3g_SRC_DIR).tgz
ntfs-3g_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	util-linux-dev_installed \
	pkg-config-dev_installed

export libntfs_3g_ABI := 88

libntfs-3g-$(libntfs_3g_ABI)_TSL_TYPE := sw
libntfs-3g-$(libntfs_3g_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
libntfs-3g-$(libntfs_3g_ABI)_TSL_SRC_PKG := ntfs-3g

ntfs-3g_TSL_TYPE := sw
ntfs-3g_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libuuid-$(libuuid_ABI)) \
	$(call bigger_equal_dep,libntfs-3g-$(libntfs_3g_ABI)) \
	$(call bigger_equal_dep,licenses)
ntfs-3g_TSL_SRC_PKG := ntfs-3g

ntfs-3g-dev_TSL_TYPE := sw
ntfs-3g-dev_TSL_RDEPS = \
	$(call equal_dep,ntfs-3g) \
	$(call equal_dep,libntfs-3g-$(libntfs_3g_ABI)) \
	$(call bigger_equal_dep,licenses)
ntfs-3g-dev_TSL_SRC_PKG := ntfs-3g

ntfs-3g_TSL_PKGS := ntfs-3g-dev libntfs-3g-$(libntfs_3g_ABI) ntfs-3g

endif
