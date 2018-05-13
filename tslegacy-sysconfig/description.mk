ifndef tslegacy-sysconfig_description_included
tslegacy-sysconfig_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

tslegacy-sysconfig_SRC_VERSION := 1.0.2
tslegacy-sysconfig_SRC_DIR := tslegacy-sysconfig-$(tslegacy-sysconfig_SRC_VERSION)
tslegacy-sysconfig_SRC_ARCHIVE := $(tslegacy-sysconfig_SRC_DIR).tar.xz
tslegacy-sysconfig_SRC_CDEPS := \
	basic_fhs-dev_installed

tslegacy-sysconfig_TSL_TYPE := conf
tslegacy-sysconfig_TSL_RDEPS = \
	$(call bigger_equal_dep,basic_fhs)
tslegacy-sysconfig_TSL_SRC_PKG := tslegacy-sysconfig

tslegacy-sysconfig_TSL_PKGS := tslegacy-sysconfig

endif
