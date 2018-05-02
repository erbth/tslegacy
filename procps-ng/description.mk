ifndef procps-ng_description_included
procps-ng_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/ncurses/description.mk

procps-ng_SRC_VERSION := 3.3.12
procps-ng_SRC_DIR := procps-ng-$(procps-ng_SRC_VERSION)
procps-ng_SRC_ARCHIVE := $(procps-ng_SRC_DIR).tar.xz
procps-ng_SRC_CDEPS := \
	licenses_installed \
	glibc-dev_installed \
	ncurses-dev_installed

export procpsng_ABI := 6

procps-ng-$(procpsng_ABI)_TSL_TYPE := sw
procps-ng-$(procpsng_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
procps-ng-$(procpsng_ABI)_TSL_SRC_PKG := procps-ng

procps-ng_TSL_TYPE := sw
procps-ng_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI)) \
	$(call bigger_equal_dep,procps-ng-$(procpsng_ABI)) \
	$(call bigger_equal_dep,licenses)
procps-ng_TSL_SRC_PKG := procps-ng

procps-ng-dev_TSL_TYPE := sw
procps-ng-dev_TSL_RDEPS = \
	$(call equal_dep,procps-ng-$(procpsng_ABI)) \
	$(call equal_dep,procps-ng) \
	$(call bigger_equal_dep,licenses)
procps-ng-dev_TSL_SRC_PKG := procps-ng

procps-ng_TSL_PKGS := procps-ng-dev procps-ng-$(procpsng_ABI) procps-ng

endif
