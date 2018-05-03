ifndef shadow_description_included
shadow_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

shadow_SRC_VERSION := 4.5
shadow_SRC_DIR := shadow-$(shadow_SRC_VERSION)
shadow_SRC_ARCHIVE := $(shadow_SRC_DIR).tar.gz
shadow_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	tslegacy-sysconfig_installed

shadow_TSL_TYPE := sw
shadow_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,tslegacy-sysconfig)
shadow_TSL_SRC_PKG := shadow

shadow-dev_TSL_TYPE := sw
shadow-dev_TSL_RDEPS = \
	$(call equal_dep,shadow)
shadow-dev_TSL_SRC_PKG := shadow

shadow_TSL_PKGS := shadow-dev shadow

endif
