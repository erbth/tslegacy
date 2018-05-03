ifndef grub_description_included
grub_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

grub_SRC_VERSION := 2.02
grub_SRC_DIR := grub-$(grub_SRC_VERSION)
grub_SRC_ARCHIVE := $(grub_SRC_DIR).tar.xz
grub_SRC_CDEPS := \
	licenses_installed \
	glibc-dev_installed \
	gcc_installed

grub_TSL_TYPE := sw
grub_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
grub_TSL_SRC_PKG := grub

grub-dev_TSL_TYPE := sw
grub-dev_TSL_RDEPS = \
	$(call equal_dep,grub) \
	$(call bigger_equal_dep,licenses)
grub-dev_TSL_SRC_PKG := grub

grub_TSL_PKGS := grub-dev grub

endif
