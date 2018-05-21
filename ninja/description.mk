ifndef ninja_description_included
ninja_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/gcc/description.mk

ninja_SRC_VERSION := 0.0.0
ninja_SRC_DIR := ninja-$(ninja_SRC_VERSION)
ninja_SRC_ARCHIVE := $(ninja_SRC_DIR).tar.xz
ninja_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	python3_installed

ninja_TSL_TYPE := sw
ninja_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI))
ninja_TSL_SRC_PKG := ninja

ninja-dev_TSL_TYPE := sw
ninja-dev_TSL_RDEPS = \
	$(call equal_dep,ninja)
ninja-dev_TSL_SRC_PKG := ninja

ninja_TSL_PKGS := ninja-dev ninja

endif
