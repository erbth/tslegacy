ifndef alsa-lib_description_included
alsa-lib_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

alsa-lib_SRC_VERSION := 1.1.6
alsa-lib_SRC_DIR := alsa-lib-$(alsa-lib_SRC_VERSION)
alsa-lib_SRC_ARCHIVE := $(alsa-lib_SRC_DIR).tar.bz2
alsa-lib_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	pkg-config-dev_installed

export libasound_ABI := 2

libasound-$(libasound_ABI)_TSL_TYPE := sw
libasound-$(libasound_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
libasound-$(libasound_ABI)_TSL_SRC_PKG := alsa-lib

alsa-lib_TSL_TYPE := sw
alsa-lib_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libasound-$(libasound_ABI)) \
	$(call bigger_equal_dep,licenses)
alsa-lib_TSL_SRC_PKG := alsa-lib

alsa-lib-dev_TSL_TYPE := sw
alsa-lib-dev_TSL_RDEPS = \
	$(call equal_dep,libasound-$(libasound_ABI)) \
	$(call equal_dep,alsa-lib) \
	$(call bigger_equal_dep,licenses)
alsa-lib-dev_TSL_SRC_PKG := alsa-lib

alsa-lib_TSL_PKGS := alsa-lib-dev alsa-lib libasound-$(libasound_ABI)

endif
