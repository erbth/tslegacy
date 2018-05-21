ifndef intltool_description_included
intltool_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

# I saw the compiletime dependency on perl in the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.
intltool_SRC_VERSION := 0.51.0
intltool_SRC_DIR := intltool-$(intltool_SRC_VERSION)
intltool_SRC_ARCHIVE := $(intltool_SRC_DIR).tar.gz
intltool_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	perl-dev_installed \
	xml-parser-dev_installed

intltool_TSL_TYPE := sw
intltool_TSL_RDEPS = \
	$(call bigger_equal_dep,perl) \
	$(call bigger_equal_dep,xml-parser) \
	$(call bigger_equal_dep,licenses)
intltool_TSL_SRC_PKG := intltool

intltool-dev_TSL_TYPE := sw
intltool-dev_TSL_RDEPS = \
	$(call equal_dep,intltool) \
	$(call bigger_equal_dep,licenses)
intltool-dev_TSL_SRC_PKG := intltool

intltool_TSL_PKGS := intltool-dev intltool

endif
