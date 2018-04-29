ifndef basic_fhs_description_included
basic_fhs_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# Information about the source package itself
basic_fhs_SRC_VERSION := 3.0
basic_fhs_SRC_ARCHIVE := basic_fhs-$(basic_fhs_SRC_VERSION).tar.xz
basic_fhs_SRC_DIR := basic_fhs-$(basic_fhs_SRC_VERSION)
basic_fhs_SRC_CDEPS := tool_links_created

# Information about the differrent packages that are built out of this source
# package.
basic_fhs_TSL_TYPE := sw
basic_fhs_TSL_RDEPS =
basic_fhs_TSL_SRC_PKG := basic_fhs

basic_fhs-dev_TSL_TYPE := sw
basic_fhs-dev_TSL_RDEPS = basic_fhs=$(call read_version,basic_fhs)
basic_fhs-dev_TSL_SRC_PKG := basic_fhs

# A list of all the packages that are built out of this source package
basic_fhs_TSL_PKGS := basic_fhs basic_fhs-dev

endif
