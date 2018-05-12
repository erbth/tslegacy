ifndef tcl-core_description_included
tcl-core_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/zlib/description.mk

tcl-core_SRC_VERSION := 8.6.8
tcl-core_SRC_DIR := tcl$(tcl-core_SRC_VERSION)
tcl-core_SRC_ARCHIVE := $(tcl-core_SRC_DIR)-src.tar.gz
tcl-core_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	zlib-dev_installed \
	pkg-config-dev_installed

tcl-core-dev_TSL_TYPE := sw
tcl-core-dev_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,zlib-$(zlib_ABI))
tcl-core-dev_TSL_SRC_PKG := tcl-core

tcl-core_TSL_PKGS := tcl-core-dev

endif
