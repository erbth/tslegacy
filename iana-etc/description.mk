ifndef iana-etc_description_included
iana-etc_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

iana-etc_SRC_VERSION := 2.30
iana-etc_SRC_DIR := iana-etc-$(iana-etc_SRC_VERSION)
iana-etc_SRC_ARCHIVE := $(iana-etc_SRC_DIR).tar.bz2
iana-etc_SRC_CDEPS := \
	basic_fhs-dev_installed

iana-etc_TSL_TYPE := sw
iana-etc_TSL_RDEPS = \
	$(call bigger_equal_dep,basic_fhs)
iana-etc_TSL_SRC_PKG := iana-etc

iana-etc_TSL_PKGS := iana-etc

endif
