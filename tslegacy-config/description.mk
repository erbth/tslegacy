ifndef tslegacy-config_description_included
tslegacy-config_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

tslegacy-config_SRC_VERSION := 1.0.0
tslegacy-config_SRC_DIR := tslegacy-config-$(tslegacy-config_SRC_VERSION)
tslegacy-config_SRC_ARCHIVE := $(tslegacy-config_SRC_DIR).tar.xz
tslegacy-config_SRC_CDEPS := \
	basic_fhs-dev_installed \
	tslegacy-sysconfig_installed

# The dependency on tslegacy-sysconfig is required, because previous versions
# included profile and bashrc files which are moved to this package.
tslegacy-config_TSL_TYPE := conf
tslegacy-config_TSL_RDEPS = \
	$(call bigger_equal_dep,basic_fhs) \
	tslegacy-sysconfig>=2018.133.74793
tslegacy-config_TSL_SRC_PKG := tslegacy-config

tslegacy-config_TSL_PKGS := tslegacy-config

endif
