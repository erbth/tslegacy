ifndef texinfo_description_included
texinfo_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/ncurses/description.mk

texinfo_SRC_VERSION := 6.5
texinfo_SRC_DIR := texinfo-$(texinfo_SRC_VERSION)
texinfo_SRC_ARCHIVE := $(texinfo_SRC_DIR).tar.xz
texinfo_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	ncurses-dev_installed

# TODO: Add gawk as dependency when a proper package is created of it.
texinfo_TSL_TYPE := sw
texinfo_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI)) \
	$(call bigger_equal_dep,bash) \
	$(call bigger_equal_dep,coreutils) \
	$(call bigger_equal_dep,licenses)
texinfo_TSL_SRC_PKG := texinfo

texinfo-dev_TSL_TYPE := sw
texinfo-dev_TSL_RDEPS = \
	$(call equal_dep,texinfo) \
	$(call bigger_equal_dep,licenses)
texinfo-dev_TSL_SRC_PKG := texinfo

texinfo_TSL_PKGS := texinfo-dev texinfo

endif
