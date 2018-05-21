ifndef pcre_description_included
pcre_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/gcc/description.mk

pcre_SRC_VERSION := 8.42
pcre_SRC_DIR := pcre-$(pcre_SRC_VERSION)
pcre_SRC_ARCHIVE := $(pcre_SRC_DIR).tar.bz2
pcre_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	zlib-dev_installed \
	bzip2-dev_installed \
	readline-dev_installed

pcre-libs_TSL_TYPE := sw
pcre-libs_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI)) \
	$(call bigger_equal_dep,licenses)
pcre-libs_TSL_SRC_PKG := pcre

pcre_TSL_TYPE := sw
pcre_TSL_RDEPS = \
	$(call bigger_equal_dep,pcre-libs) \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI)) \
	$(call bigger_equal_dep,licenses)
pcre_TSL_SRC_PKG := pcre

pcre-dev_TSL_TYPE := sw
pcre-dev_TSL_RDEPS = \
	$(call equal_dep,pcre) \
	$(call bigger_equal_dep,licenses)
pcre-dev_TSL_SRC_PKG := pcre

pcre_TSL_PKGS := pcre-dev pcre pcre-libs

endif
