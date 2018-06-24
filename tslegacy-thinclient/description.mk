ifndef tslegacy-thinclient_description_included
tslegacy-thinclient_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

tslegacy-thinclient_SRC_VERSION := 1.0.0
tslegacy-thinclient_SRC_DIR := tslegacy-thinclient-$(tslegacy-thinclient_SRC_VERSION)
tslegacy-thinclient_SRC_ARCHIVE := $(tslegacy-thinclient_SRC_DIR).tar.xz
tslegacy-thinclient_SRC_CDEPS := \
	toolchain_installed

tslegacy-thinclient_TSL_TYPE := sw
tslegacy-thinclient_TSL_RDEPS = \
	$(call bigger_equal_dep,tslegacy-config) \
	$(call bigger_equal_dep,util-linux) \
	$(call bigger_equal_dep,procps-ng) \
	$(call bigger_equal_dep,tslegacy-bootscripts) \
	$(call bigger_equal_dep,xinit)
tslegacy-thinclient_TSL_SRC_PKG := tslegacy-thinclient


tslegacy-thinclient_TSL_PKGS := tslegacy-thinclient

endif
