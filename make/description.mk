ifndef make_description_included
make_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

make_SRC_VERSION := 4.2.1
make_SRC_DIR := make-$(make_SRC_VERSION)
make_SRC_ARCHIVE := $(make_SRC_DIR).tar.bz2
make_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

make_TSL_TYPE := sw
make_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
make_TSL_SRC_PKG := make

make-dev_TSL_TYPE := sw
make-dev_TSL_RDEPS = \
	$(call equal_dep,make) \
	$(call bigger_equal_dep,licenses)
make-dev_TSL_SRC_PKG := make

make_TSL_PKGS := make-dev make

endif
