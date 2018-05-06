ifndef file_description_included
file_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/zlib/description.mk

file_SRC_VERSION := 5.32
file_SRC_DIR := file-$(file_SRC_VERSION)
file_SRC_ARCHIVE := $(file_SRC_DIR).tar.gz
file_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	zlib-dev_installed

export libmagic_ABI := 1

libmagic-$(libmagic_ABI)_TSL_TYPE := sw
libmagic-$(libmagic_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,zlib-$(zlib_ABI))
libmagic-$(libmagic_ABI)_TSL_SRC_PKG := file

file_TSL_TYPE := sw
file_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,zlib-$(zlib_ABI)) \
	$(call bigger_equal_dep,libmagic-$(libmagic_ABI))
file_TSL_SRC_PKG := file

file-dev_TSL_TYPE := sw
file-dev_TSL_RDEPS = \
	$(call equal_dep,file) \
	$(call equal_dep,libmagic-$(libmagic_ABI))
file-dev_TSL_SRC_PKG := file

file_TSL_PKGS := file-dev file libmagic-$(libmagic_ABI)

endif
