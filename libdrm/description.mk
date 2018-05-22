ifndef libdrm_description_included
libdrm_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

libdrm_SRC_VERSION := 2.4.92
libdrm_SRC_DIR := libdrm-$(libdrm_SRC_VERSION)
libdrm_SRC_ARCHIVE := $(libdrm_SRC_DIR).tar.bz2
libdrm_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	libpciaccess-dev_installed

libdrm_TSL_TYPE := sw
libdrm_TSL_RDEPS =
libdrm_TSL_SRC_PKG := libdrm

libdrm-dev_TSL_TYPE := sw
libdrm-dev_TSL_RDEPS = \
	$(call equal_dep,libdrm)
libdrm-dev_TSL_SRC_PKG := libdrm

libdrm_TSL_PKGS := libdrm-dev libdrm

endif
