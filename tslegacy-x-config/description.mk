ifndef tslegacy-x-config_description_included
tslegacy-x-config_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

tslegacy-x-config_SRC_VERSION := 1.0.0
tslegacy-x-config_SRC_DIR := tslegacy-x-config-$(tslegacy-x-config_SRC_VERSION)
tslegacy-x-config_SRC_ARCHIVE := $(tslegacy-x-config_SRC_DIR).tar.xz
tslegacy-x-config_SRC_CDEPS := \
	basic_fhs-dev_installed \
	tslegacy-sysconfig_installed

# The dependency on tslegacy-sysconfig is required, because previous versions
# included profile and bashrc files which are moved to this package.
tslegacy-x-config_TSL_TYPE := conf
tslegacy-x-config_TSL_RDEPS = \
	$(call bigger_equal_dep,basic_fhs) \
	$(call bigger_equal_dep,tslegacy-config)
tslegacy-x-config_TSL_SRC_PKG := tslegacy-x-config

tslegacy-x-config_TSL_PKGS := tslegacy-x-config

endif
