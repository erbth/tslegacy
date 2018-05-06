ifndef expat_description_included
expat_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

expat_SRC_VERSION := 2.2.5
expat_SRC_DIR := expat-$(expat_SRC_VERSION)
expat_SRC_ARCHIVE := $(expat_SRC_DIR).tar.bz2
expat_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	pkg-config-dev_installed

export libexpat_ABI := 1

libexpat-$(libexpat_ABI)_TSL_TYPE := sw
libexpat-$(libexpat_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
libexpat-$(libexpat_ABI)_TSL_SRC_PKG := expat

expat_TSL_TYPE := sw
expat_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libexpat-$(libexpat_ABI))
expat_TSL_SRC_PKG := expat

expat-dev_TSL_TYPE := sw
expat-dev_TSL_RDEPS = \
	$(call equal_dep,expat) \
	$(call equal_dep,libexpat-$(libexpat_ABI))
expat-dev_TSL_SRC_PKG := expat

expat_TSL_PKGS := expat-dev expat libexpat-$(libexpat_ABI)

endif
