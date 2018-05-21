ifndef libXdmcp_description_included
libXdmcp_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/gcc/description.mk

libXdmcp_SRC_VERSION := 1.1.2
libXdmcp_SRC_DIR := libXdmcp-$(libXdmcp_SRC_VERSION)
libXdmcp_SRC_ARCHIVE := $(libXdmcp_SRC_DIR).tar.bz2
libXdmcp_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	x-proto-headers-dev_installed

libXdmcp_TSL_TYPE := sw
libXdmcp_TSL_RDEPS =
libXdmcp_TSL_SRC_PKG := libXdmcp

libXdmcp-dev_TSL_TYPE := sw
libXdmcp-dev_TSL_RDEPS = \
	$(call equal_dep,libXdmcp)
libXdmcp-dev_TSL_SRC_PKG := libXdmcp

libXdmcp_TSL_PKGS := libXdmcp-dev libXdmcp

endif
