ifndef less_description_included
less_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/ncurses/description.mk

less_SRC_VERSION := 530
less_SRC_DIR := less-$(less_SRC_VERSION)
less_SRC_ARCHIVE := $(less_SRC_DIR).tar.gz
less_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	ncurses-dev_installed

less_TSL_TYPE := sw
less_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI)) \
	$(call bigger_equal_dep,licenses)
less_TSL_SRC_PKG := less

less-dev_TSL_TYPE := sw
less-dev_TSL_RDEPS = \
	$(call equal_dep,less) \
	$(call bigger_equal_dep,licenses)
less-dev_TSL_SRC_PKG := less

less_TSL_PKGS := less-dev less

endif
