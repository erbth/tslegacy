ifndef ncurses_description_included
ncurses_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

ncurses_SRC_VERSION := 6.1
ncurses_SRC_DIR := ncurses-$(ncurses_SRC_VERSION)
ncurses_SRC_ARCHIVE := $(ncurses_SRC_DIR).tar.gz
ncurses_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	pkg-config-dev_installed

export ncurses_ABI := 6

ncurses_TSL_TYPE := sw
ncurses_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI)) \
	$(call bigger_equal_dep,licenses)
ncurses_TSL_SRC_PKG := ncurses

ncurses-$(ncurses_ABI)_TSL_TYPE := sw
ncurses-$(ncurses_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
ncurses-$(ncurses_ABI)_TSL_SRC_PKG := ncurses

ncurses-dev_TSL_TYPE := sw
ncurses-dev_TSL_RDEPS = \
	$(call equal_dep,ncurses) \
	$(call equal_dep,ncurses-$(ncurses_ABI)) \
	$(call bigger_equal_dep,licenses)
ncurses-dev_TSL_SRC_PKG := ncurses

ncurses_TSL_PKGS := ncurses-dev ncurses ncurses-$(ncurses_ABI)

endif
