ifndef autoconf_description_included
autoconf_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

autoconf_SRC_VERSION := 2.69
autoconf_SRC_DIR := autoconf-$(autoconf_SRC_VERSION)
autoconf_SRC_ARCHIVE := $(autoconf_SRC_DIR).tar.xz
autoconf_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

autoconf_TSL_TYPE := sw
autoconf_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses)
autoconf_TSL_SRC_PKG := autoconf

autoconf-dev_TSL_TYPE := sw
autoconf-dev_TSL_RDEPS = \
	$(call equal_dep,autoconf) \
	$(call bigger_equal_dep,licenses)
autoconf-dev_TSL_SRC_PKG := autoconf

autoconf_TSL_PKGS := autoconf-dev autoconf

endif
