ifndef m4_description_included
m4_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

m4_SRC_VERSION := 1.4.18
m4_SRC_DIR := m4-$(m4_SRC_VERSION)
m4_SRC_ARCHIVE := $(m4_SRC_DIR).tar.xz
m4_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

m4-dev_TSL_TYPE := sw
m4-dev_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
m4-dev_TSL_SRC_PKG := m4

m4_TSL_PKGS := m4-dev

endif
