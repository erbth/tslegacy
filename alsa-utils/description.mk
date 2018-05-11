ifndef alsa-utils_description_included
alsa-utils_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/ncurses/description.mk
include $(PACKAGING_RESOURCE_DIR)/alsa-lib/description.mk

alsa-utils_SRC_VERSION := 1.1.6
alsa-utils_SRC_DIR := alsa-utils-$(alsa-utils_SRC_VERSION)
alsa-utils_SRC_ARCHIVE := $(alsa-utils_SRC_DIR).tar.bz2
alsa-utils_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	ncurses-dev_installed \
	alsa-lib-dev_installed

alsa-utils_TSL_TYPE := sw
alsa-utils_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI)) \
	$(call bigger_equal_dep,libasound-$(libasound_ABI)) \
	$(call bigger_equal_dep,licenses)
alsa-utils_TSL_SRC_PKG := alsa-utils

alsa-utils-dev_TSL_TYPE := sw
alsa-utils-dev_TSL_RDEPS = \
	$(call equal_dep,alsa-utils) \
	$(call bigger_equal_dep,licenses)
alsa-utils-dev_TSL_SRC_PKG := alsa-utils

alsa-utils_TSL_PKGS := alsa-utils-dev alsa-utils

endif
