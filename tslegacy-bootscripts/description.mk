ifndef tslegacy-bootscripts_description_included
tslegacy-bootscripts_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

tslegacy-bootscripts_SRC_VERSION := 1.0.1
tslegacy-bootscripts_SRC_DIR := tslegacy-bootscripts-$(tslegacy-bootscripts_SRC_VERSION)
tslegacy-bootscripts_SRC_ARCHIVE := $(tslegacy-bootscripts_SRC_DIR).tar.xz
tslegacy-bootscripts_SRC_CDEPS := \
	basic_fhs-dev_installed

tslegacy-bootscripts_TSL_TYPE := sw
tslegacy-bootscripts_TSL_RDEPS = \
	$(call bigger_equal_dep,sed) \
	$(call bigger_equal_dep,coreutils) \
	$(call bigger_equal_dep,grep) \
	$(call bigger_equal_dep,findutils) \
	$(call bigger_equal_dep,bash) \
	$(call bigger_equal_dep,iproute2) \
	$(call bigger_equal_dep,isc-dhcp-client) \
	$(call bigger_equal_dep,basic_fhs)
tslegacy-bootscripts_TSL_SRC_PKG := tslegacy-bootscripts

tslegacy-bootscripts-dev_TSL_TYPE := sw
tslegacy-bootscripts-dev_TSL_RDEPS = \
	$(call equal_dep,tslegacy-bootscripts)
tslegacy-bootscripts-dev_TSL_SRC_PKG := tslegacy-bootscripts

tslegacy-bootscripts_TSL_PKGS := tslegacy-bootscripts-dev tslegacy-bootscripts

endif
