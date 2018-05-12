ifndef bison_description_included
bison_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

bison_SRC_VERSION := 3.0.4
bison_SRC_DIR := bison-$(bison_SRC_VERSION)
bison_SRC_ARCHIVE := $(bison_SRC_DIR).tar.xz
bison_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	m4-dev_installed

bison-dev_TSL_TYPE := sw
bison-dev_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,bash) \
	$(call bigger_equal_dep,m4-dev) \
	$(call bigger_equal_dep,licenses)
bison-dev_TSL_SRC_PKG := bison

bison_TSL_PKGS := bison-dev

endif
