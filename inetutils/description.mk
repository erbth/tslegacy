ifndef inetutils_description_included
inetutils_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/ncurses/description.mk
include $(PACKAGING_RESOURCE_DIR)/readline/description.mk

inetutils_SRC_VERSION := 1.9.4
inetutils_SRC_DIR := inetutils-$(inetutils_SRC_VERSION)
inetutils_SRC_ARCHIVE := $(inetutils_SRC_DIR).tar.xz
inetutils_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	ncurses-dev_installed \
	readline-dev_installed

# The dependency on coreutils is required since earlier versions of coreutils
# included its hostname program. Now inetutils hostname program shall be
# installed.
inetutils_TSL_TYPE := sw
inetutils_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI)) \
	$(call bigger_equal_dep,readline-$(readline_ABI)) \
	coreutils>=2018.130.74317 \
	$(call bigger_equal_dep,licenses)
inetutils_TSL_SRC_PKG := inetutils

inetutils-dev_TSL_TYPE := sw
inetutils-dev_TSL_RDEPS = \
	$(call equal_dep,inetutils) \
	$(call bigger_equal_dep,licenses)
inetutils-dev_TSL_SRC_PKG := inetutils

inetutils_TSL_PKGS := inetutils-dev inetutils

endif
