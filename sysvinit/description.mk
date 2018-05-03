ifndef sysvinit_description_included
sysvinit_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

sysvinit_SRC_VERSION := 2.88dsf
sysvinit_SRC_DIR := sysvinit-$(sysvinit_SRC_VERSION)
sysvinit_SRC_ARCHIVE := $(sysvinit_SRC_DIR).tar.bz2
sysvinit_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

sysvinit_TSL_TYPE := sw
sysvinit_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
sysvinit_TSL_SRC_PKG := sysvinit

sysvinit-dev_TSL_TYPE := sw
sysvinit-dev_TSL_RDEPS = \
	$(call equal_dep,sysvinit) \
	$(call bigger_equal_dep,licenses)
sysvinit-dev_TSL_SRC_PKG := sysvinit

sysvinit_TSL_PKGS := sysvinit-dev sysvinit

endif
