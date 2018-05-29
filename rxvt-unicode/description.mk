ifndef rxvt-unicode_description_included
rxvt-unicode_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# ncurses is needed for tic
rxvt-unicode_SRC_VERSION := 9.22
rxvt-unicode_SRC_DIR := rxvt-unicode-$(rxvt-unicode_SRC_VERSION)
rxvt-unicode_SRC_ARCHIVE := $(rxvt-unicode_SRC_DIR).tar.bz2
rxvt-unicode_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	fontconfig-dev_installed \
	freetype-dev_installed \
	xorg-libraries-dev_installed \
	ncurses-dev_installed

rxvt-unicode_TSL_TYPE := sw
rxvt-unicode_TSL_RDEPS =
rxvt-unicode_TSL_SRC_PKG := rxvt-unicode

rxvt-unicode-dev_TSL_TYPE := sw
rxvt-unicode-dev_TSL_RDEPS = \
	$(call equal_dep,rxvt-unicode)
rxvt-unicode-dev_TSL_SRC_PKG := rxvt-unicode

rxvt-unicode_TSL_PKGS := rxvt-unicode-dev rxvt-unicode

endif
