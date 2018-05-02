ifndef pkg-config_description_included
pkg-config_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

pkg-config_SRC_VERSION := 0.29.2
pkg-config_SRC_DIR := pkg-config-$(pkg-config_SRC_VERSION)
pkg-config_SRC_ARCHIVE := $(pkg-config_SRC_DIR).tar.gz
pkg-config_SRC_CDEPS := \
	licenses_installed \
	gcc_installed

pkg-config_TSL_TYPE := sw
pkg-config_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
pkg-config_TSL_SRC_PKG := pkg-config

pkg-config-dev_TSL_TYPE := sw
pkg-config-dev_TSL_RDEPS = \
	$(call equal_dep,pkg-config) \
	$(call bigger_equal_dep,licenses)
pkg-config-dev_TSL_SRC_PKG := pkg-config

pkg-config_TSL_PKGS := pkg-config-dev pkg-config

endif
