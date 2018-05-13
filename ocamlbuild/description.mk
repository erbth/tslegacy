ifndef ocamlbuild_description_included
ocamlbuild_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/gcc/description.mk

ocamlbuild_SRC_VERSION := 0.12.0
ocamlbuild_SRC_DIR := ocamlbuild-$(ocamlbuild_SRC_VERSION)
ocamlbuild_SRC_ARCHIVE := $(ocamlbuild_SRC_DIR).tar.gz
ocamlbuild_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	ocaml-dev_installed \
	findlib-dev_installed

ocamlbuild_TSL_TYPE := sw
ocamlbuild_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
ocamlbuild_TSL_SRC_PKG := ocamlbuild

ocamlbuild-dev_TSL_TYPE := sw
ocamlbuild-dev_TSL_RDEPS = \
	$(call equal_dep,ocamlbuild)
ocamlbuild-dev_TSL_SRC_PKG := ocamlbuild

ocamlbuild_TSL_PKGS := ocamlbuild-dev ocamlbuild

endif
