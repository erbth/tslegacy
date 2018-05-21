ifndef icu_description_included
icu_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

icu_SRC_VERSION := 61.1
icu_SRC_DIR := icu
icu_SRC_ARCHIVE := icu4c-61_1-src.tgz
icu_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed

icu-libs_TSL_TYPE := sw
icu-libs_TSL_RDEPS =
icu-libs_TSL_SRC_PKG := icu

icu_TSL_TYPE := sw
icu_TSL_RDEPS = \
	$(call bigger_equal_dep,icu-libs)
icu_TSL_SRC_PKG := icu

icu-dev_TSL_TYPE := sw
icu-dev_TSL_RDEPS = \
	$(call equal_dep,icu-libs) \
	$(call equal_dep,icu)
icu-dev_TSL_SRC_PKG := icu

icu_TSL_PKGS := icu-dev icu-libs icu

endif
