ifndef util-macros_description_included
util-macros_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

util-macros_SRC_VERSION := 1.19.2
util-macros_SRC_DIR := util-macros-$(util-macros_SRC_VERSION)
util-macros_SRC_ARCHIVE := $(util-macros_SRC_DIR).tar.bz2
util-macros_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	m4-dev_installed

util-macros_TSL_TYPE := sw
util-macros_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,m4-dev)
util-macros_TSL_SRC_PKG := util-macros

util-macros-dev_TSL_TYPE := sw
util-macros-dev_TSL_RDEPS = \
	$(call equal_dep,util-macros)
util-macros-dev_TSL_SRC_PKG := util-macros

util-macros_TSL_PKGS := util-macros-dev util-macros

endif
