ifndef util-linux_description_included
util-linux_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/ncurses/description.mk
include $(PACKAGING_RESOURCE_DIR)/readline/description.mk
# include $(PACKAGING_RESOURCE_DIR)/eudev/description.mk
include $(PACKAGING_RESOURCE_DIR)/zlib/description.mk

util-linux_SRC_VERSION := 2.32
util-linux_SRC_DIR := util-linux-$(util-linux_SRC_VERSION)
util-linux_SRC_ARCHIVE := $(util-linux_SRC_DIR).tar
util-linux_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	ncurses-dev_installed \
	readline-dev_installed \
	zlib-dev_installed \
#	eudev-dev_installed

export libblkid_ABI := 1
export libfdisk_ABI := 1
export libmount_ABI := 1
export libsmartcols_ABI := 1
export libuuid_ABI := 1

# libblkid
libblkid-$(libblkid_ABI)_TSL_TYPE := sw
libblkid-$(libblkid_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libuuid-$(libuuid_ABI)) \
	$(call bigger_equal_dep,licenses)
libblkid-$(libblkid_ABI)_TSL_SRC_PKG := util-linux

# libfdisk
libfdisk-$(libfdisk_ABI)_TSL_TYPE := sw
libfdisk-$(libfdisk_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libuuid-$(libuuid_ABI)) \
	$(call bigger_equal_dep,libblkid-$(libblkid_ABI)) \
	$(call bigger_equal_dep,licenses)
libfdisk-$(libfdisk_ABI)_TSL_SRC_PKG := util-linux

# libmount
libmount-$(libmount_ABI)_TSL_TYPE := sw
libmount-$(libmount_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libuuid-$(libuuid_ABI)) \
	$(call bigger_equal_dep,libblkid-$(libblkid_ABI)) \
	$(call bigger_equal_dep,licenses)
libmount-$(libmount_ABI)_TSL_SRC_PKG := util-linux

# libsmartcols
libsmartcols-$(libsmartcols_ABI)_TSL_TYPE := sw
libsmartcols-$(libsmartcols_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
libsmartcols-$(libsmartcols_ABI)_TSL_SRC_PKG := util-linux

# libuuid
libuuid-$(libuuid_ABI)_TSL_TYPE := sw
libuuid-$(libuuid_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
libuuid-$(libuuid_ABI)_TSL_SRC_PKG := util-linux


# util-linux
util-linux_TSL_TYPE := sw
util-linux_TSL_RDEPS = \
	$(call bigger_equal_dep,libblkid-$(libblkid_ABI)) \
	$(call bigger_equal_dep,libfdisk-$(libfdisk_ABI)) \
	$(call bigger_equal_dep,libmount-$(libmount_ABI)) \
	$(call bigger_equal_dep,libsmartcols-$(libsmartcols_ABI)) \
	$(call bigger_equal_dep,libuuid-$(libuuid_ABI)) \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI)) \
	$(call bigger_equal_dep,readline-$(readline_ABI)) \
	$(call bigger_equal_dep,zlib-$(zlib_ABI)) \
	$(call bigger_equal_dep,licenses)
util-linux_TSL_SRC_PKG := util-linux

# util-linux-dev
util-linux-dev_TSL_TYPE := sw
util-linux-dev_TSL_RDEPS = \
	$(call equal_dep,libblkid-$(libblkid_ABI)) \
	$(call equal_dep,libfdisk-$(libfdisk_ABI)) \
	$(call equal_dep,libmount-$(libmount_ABI)) \
	$(call equal_dep,libsmartcols-$(libsmartcols_ABI)) \
	$(call equal_dep,libuuid-$(libuuid_ABI)) \
	$(call equal_dep,util-linux) \
	$(call bigger_equal_dep,licenses)
util-linux-dev_TSL_SRC_PKG := util-linux

export util-linux_TSL_PKGS := \
	libblkid-$(libblkid_ABI) \
	libfdisk-$(libfdisk_ABI) \
	libmount-$(libmount_ABI) \
	libsmartcols-$(libsmartcols_ABI) \
	libuuid-$(libuuid_ABI) \
	util-linux \
	util-linux-dev

endif
