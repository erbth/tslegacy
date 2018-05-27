ifndef dejagnu_description_included
dejagnu_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

dejagnu_SRC_VERSION := 1.6.1
dejagnu_SRC_DIR := dejagnu-$(dejagnu_SRC_VERSION)
dejagnu_SRC_ARCHIVE := $(dejagnu_SRC_DIR).tar.gz
dejagnu_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	bash-dev_installed \
	expect-dev_installed

dejagnu-dev_TSL_TYPE := sw
dejagnu-dev_TSL_RDEPS = \
	$(call bigger_equal_dep,bash) \
	$(call bigger_equal_dep,licenses)
dejagnu-dev_TSL_SRC_PKG := dejagnu

dejagnu_TSL_PKGS := dejagnu-dev

endif
