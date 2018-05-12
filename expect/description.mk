ifndef expect_description_included
expect_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/tcl-core/description.mk

expect_SRC_VERSION := 5.45.4
expect_SRC_DIR := expect$(expect_SRC_VERSION)
expect_SRC_ARCHIVE := $(expect_SRC_DIR).tar.gz
expect_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	tcl-core-dev_installed

expect-dev_TSL_TYPE := sw
expect-dev_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI))
expect-dev_TSL_SRC_PKG := expect

expect_TSL_PKGS := expect-dev

endif
