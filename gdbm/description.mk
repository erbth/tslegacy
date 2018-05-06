ifndef gdbm_description_included
gdbm_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

gdbm_SRC_VERSION := 1.9.1
gdbm_SRC_DIR := gdbm-$(gdbm_SRC_VERSION)
gdbm_SRC_ARCHIVE := $(gdbm_SRC_DIR).tar.gz
gdbm_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

export libgdbm_ABI := 4
export libgdbm_compat_ABI := 4

libgdbm-$(libgdbm_ABI)_TSL_TYPE := sw
libgdbm-$(libgdbm_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
libgdbm-$(libgdbm_ABI)_TSL_SRC_PKG := gdbm

libgdbm-compat-$(libgdbm_compat_ABI)_TSL_TYPE := sw
libgdbm-compat-$(libgdbm_compat_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
libgdbm-compat-$(libgdbm_compat_ABI)_TSL_SRC_PKG := gdbm

gdbm_TSL_TYPE := sw
gdbm_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgdbm-$(libgdbm_ABI)) \
	$(call bigger_equal_dep,licenses)
gdbm_TSL_SRC_PKG := gdbm

gdbm-dev_TSL_TYPE := sw
gdbm-dev_TSL_RDEPS = \
	$(call equal_dep,libgdbm-$(libgdbm_ABI)) \
	$(call equal_dep,libgdbm-compat-$(libgdbm_compat_ABI)) \
	$(call equal_dep,gdbm) \
	$(call bigger_equal_dep,licenses)
gdbm-dev_TSL_SRC_PKG := gdbm

gdbm_TSL_PKGS := \
	libgdbm-$(libgdbm_ABI) \
	libgdbm-compat-$(libgdbm_compat_ABI) \
	gdbm \
	gdbm-dev

endif
