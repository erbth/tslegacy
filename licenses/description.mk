ifndef licenses_description_included
licenses_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# Information about the source package itself
licenses_SRC_VERSION := 1.0
licenses_SRC_ARCHIVE := licenses-$(licenses_SRC_VERSION).tar.gz
licenses_SRC_DIR := licenses-$(licenses_SRC_VERSION)
licenses_SRC_CDEPS := basic_fhs-dev_installed

# Information about the differrent packages that are built out of this source
# package.
licenses_TSL_TYPE := sw
licenses_TSL_RDEPS = $(call bigger_or_equal_dep,basic_fhs)
licenses_TSL_SRC_PKG := licenses

# A list of all the packages that are built out of this source package
licenses_TSL_PKGS := licenses

endif
