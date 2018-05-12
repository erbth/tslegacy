ifndef gettext_description_included
gettext_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/gcc/description.mk
include $(PACKAGING_RESOURCE_DIR)/ncurses/description.mk

gettext_SRC_VERSION := 0.19.8
gettext_SRC_DIR := gettext-$(gettext_SRC_VERSION)
gettext_SRC_ARCHIVE := $(gettext_SRC_DIR).tar.xz
gettext_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	ncurses-dev_installed

gettext-dev_TSL_TYPE := sw
gettext-dev_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgomp-$(libgomp_ABI)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI)) \
	$(call bigger_equal_dep,licenses)
gettext-dev_TSL_SRC_PKG := gettext

gettext_TSL_PKGS := gettext-dev

endif
