ifndef markup-safe_description_included
markup-safe_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

markup-safe_SRC_VERSION := 1.0
markup-safe_SRC_DIR := MarkupSafe-$(markup-safe_SRC_VERSION)
markup-safe_SRC_ARCHIVE := $(markup-safe_SRC_DIR).tar.gz
markup-safe_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	python-dev_installed \
	python3-dev_installed \
	gdbm-dev_installed

markup-safe_TSL_TYPE := sw
markup-safe_TSL_RDEPS =
markup-safe_TSL_SRC_PKG := markup-safe

markup-safe_TSL_PKGS := markup-safe

endif
