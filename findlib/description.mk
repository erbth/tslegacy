ifndef findlib_description_included
findlib_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

findlib_SRC_VERSION := 1.7.3
findlib_SRC_DIR := findlib-$(findlib_SRC_VERSION)
findlib_SRC_ARCHIVE := $(findlib_SRC_DIR).tar.gz
findlib_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	ocaml-dev_installed \
	m4-dev_installed

findlib_TSL_TYPE := sw
findlib_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
findlib_TSL_SRC_PKG := findlib

findlib-dev_TSL_TYPE := sw
findlib-dev_TSL_RDEPS = \
	$(call equal_dep,findlib)
findlib-dev_TSL_SRC_PKG := findlib

findlib_TSL_PKGS := findlib-dev findlib

endif
