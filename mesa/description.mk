ifndef mesa_description_included
mesa_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

mesa_SRC_VERSION := 18.1.0
mesa_SRC_DIR := mesa-$(mesa_SRC_VERSION)
mesa_SRC_ARCHIVE := $(mesa_SRC_DIR).tar.xz
mesa_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	

mesa_TSL_TYPE := sw
mesa_TSL_RDEPS =
mesa_TSL_SRC_PKG := mesa

mesa-dev_TSL_TYPE := sw
mesa-dev_TSL_RDEPS = \
	$(call equal_dep,mesa)
mesa-dev_TSL_SRC_PKG := mesa

mesa_TSL_PKGS := mesa-dev mesa

endif
