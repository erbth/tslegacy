ifndef linux_description_included
linux_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

linux_SRC_VERSION := 4.16.12
linux_SRC_DIR := linux-$(linux_SRC_VERSION)
linux_SRC_ARCHIVE := $(linux_SRC_DIR).tar
linux_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	bc-dev_installed \
	openssl-dev_installed \
	elfutils-dev_installed \
	kmod-dev_installed

linux_TSL_TYPE := sw
linux_TSL_RDEPS = \
	$(call bigger_equal_dep,basic_fhs) \
	$(call bigger_equal_dep,licenses)
linux_TSL_SRC_PKG := linux

linux-doc_TSL_TYPE := sw
linux-doc_TSL_RDEPS = \
	$(call bigger_equal_dep,basic_fhs) \
	$(call bigger_equal_dep,licenses)
linux-doc_TSL_SRC_PKG := linux

linux_TSL_PKGS := linux linux-doc

endif
