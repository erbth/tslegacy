ifndef e2fsprogs_description_included
e2fsprogs_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/util-linux/description.mk

e2fsprogs_SRC_VERSION := 1.44.1
e2fsprogs_SRC_DIR := e2fsprogs-$(e2fsprogs_SRC_VERSION)
e2fsprogs_SRC_ARCHIVE := $(e2fsprogs_SRC_DIR).tar
e2fsprogs_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	util-linux-dev_installed

export libcom_err_ABI := 2
export libe2p_ABI := 2
export libext2fs_ABI := 2
export libss_ABI := 2

libcom_err-$(libcom_err_ABI)_TSL_TYPE := sw
libcom_err-$(libcom_err_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
libcom_err-$(libcom_err_ABI)_TSL_SRC_PKG := e2fsprogs

libe2p-$(libe2p_ABI)_TSL_TYPE := sw
libe2p-$(libe2p_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
libe2p-$(libe2p_ABI)_TSL_SRC_PKG := e2fsprogs

libext2fs-$(libext2fs_ABI)_TSL_TYPE := sw
libext2fs-$(libext2fs_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libcom_err-$(libcom_err_ABI)) \
	$(call bigger_equal_dep,licenses)
libext2fs-$(libext2fs_ABI)_TSL_SRC_PKG := e2fsprogs

libss-$(libss_ABI)_TSL_TYPE := sw
libss-$(libss_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libcom_err-$(libcom_err_ABI))
libss-$(libss_ABI)_TSL_SRC_PKG := e2fsprogs

e2fsprogs_TSL_TYPE := sw
e2fsprogs_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libblkid-$(libblkid_ABI)) \
	$(call bigger_equal_dep,libuuid-$(libuuid_ABI)) \
	$(call bigger_equal_dep,libcom_err-$(libcom_err_ABI)) \
	$(call bigger_equal_dep,libe2p-$(libe2p_ABI)) \
	$(call bigger_equal_dep,libext2fs-$(libext2fs_ABI)) \
	$(call bigger_equal_dep,libss-$(libss_ABI)) \
	$(call bigger_equal_dep,licenses)
e2fsprogs_TSL_SRC_PKG := e2fsprogs

e2fsprogs-dev_TSL_TYPE := sw
e2fsprogs-dev_TSL_RDEPS = \
	$(call equal_dep,libcom_err-$(libcom_err_ABI)) \
	$(call equal_dep,libe2p-$(libe2p_ABI)) \
	$(call equal_dep,libext2fs-$(libext2fs_ABI)) \
	$(call equal_dep,libss-$(libss_ABI)) \
	$(call equal_dep,e2fsprogs) \
	$(call bigger_equal_dep,licenses)
e2fsprogs-dev_TSL_SRC_PKG := e2fsprogs

e2fsprogs_TSL_PKGS := \
	libcom_err-$(libcom_err_ABI) \
	libe2p-$(libe2p_ABI) \
	libext2fs-$(libext2fs_ABI) \
	libss-$(libss_ABI) \
	e2fsprogs-dev \
	e2fsprogs
endif
