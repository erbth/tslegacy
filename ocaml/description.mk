ifndef ocaml_description_included
ocaml_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/ncurses/description.mk

ocaml_SRC_VERSION := 4.06.0
ocaml_SRC_DIR := ocaml-$(ocaml_SRC_VERSION)
ocaml_SRC_ARCHIVE := $(ocaml_SRC_DIR).tar.xz
ocaml_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	ncurses-dev_installed \
	binutils_installed

ocaml_TSL_TYPE := sw
ocaml_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI))
ocaml_TSL_SRC_PKG := ocaml

ocaml-runtime_TSL_TYPE := sw
ocaml-runtime_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI))
ocaml-runtime_TSL_SRC_PKG := ocaml

ocaml-dev_TSL_TYPE := sw
ocaml-dev_TSL_RDEPS = \
	$(call equal_dep,ocaml-runtime) \
	$(call equal_dep,ocaml) \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI)) \
	$(call bigger_equal_dep,binutils)
ocaml-dev_TSL_SRC_PKG := ocaml

ocaml_TSL_PKGS := ocaml-dev ocaml ocaml-runtime

endif
