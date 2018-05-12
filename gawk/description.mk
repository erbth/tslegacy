ifndef gawk_description_included
gawk_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/gmp/description.mk
include $(PACKAGING_RESOURCE_DIR)/mpfr/description.mk
include $(PACKAGING_RESOURCE_DIR)/readline/description.mk
include $(PACKAGING_RESOURCE_DIR)/ncurses/description.mk

gawk_SRC_VERSION := 4.2.1
gawk_SRC_DIR := gawk-$(gawk_SRC_VERSION)
gawk_SRC_ARCHIVE := $(gawk_SRC_DIR).tar.xz
gawk_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

gawk-dev_TSL_TYPE := sw
gawk-dev_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,gmp-$(gmp_ABI)) \
	$(call bigger_equal_dep,mpfr-$(mpfr_ABI)) \
	$(call bigger_equal_dep,readline-$(readline_ABI)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI)) \
	$(call bigger_equal_dep,licenses)
gawk-dev_TSL_SRC_PKG := gawk

gawk_TSL_PKGS := gawk-dev

endif
