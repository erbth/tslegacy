ifndef xml-parser_description_included
xml-parser_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/expat/description.mk

xml-parser_SRC_VERSION := 2.44
xml-parser_SRC_DIR := XML-Parser-$(xml-parser_SRC_VERSION)
xml-parser_SRC_ARCHIVE := $(xml-parser_SRC_DIR).tar.gz
xml-parser_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	perl-dev_installed \
	expat-dev_installed

xml-parser_TSL_TYPE := sw
xml-parser_TSL_RDEPS =
xml-parser_TSL_SRC_PKG := xml-parser

xml-parser-dev_TSL_TYPE := sw
xml-parser-dev_TSL_RDEPS = \
	$(call equal_dep,xml-parser)
xml-parser-dev_TSL_SRC_PKG := xml-parser

xml-parser_TSL_PKGS := xml-parser-dev xml-parser

endif
