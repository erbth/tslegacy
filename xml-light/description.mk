ifndef xml-light_description_included
xml-light_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

xml-light_SRC_VERSION := 2.4
xml-light_SRC_DIR := xml-light-$(xml-light_SRC_VERSION)
xml-light_SRC_ARCHIVE := $(xml-light_SRC_DIR).tar.gz
xml-light_SRC_CDEPS := \
	licenses_installed \
	ocaml-dev_installed \
	findlib-dev_installed

xml-light_TSL_TYPE := sw
xml-light_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
xml-light_TSL_SRC_PKG := xml-light

xml-light_TSL_PKGS := xml-light

endif
