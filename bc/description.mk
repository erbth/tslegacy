ifndef bc_description_included
bc_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/readline/description.mk
include $(PACKAGING_RESOURCE_DIR)/ncurses/description.mk

export bc_SRC_VERSION := 1.7.1
bc_SRC_DIR := bc-1.07.1
bc_SRC_ARCHIVE := $(bc_SRC_DIR).tar.gz
bc_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	readline-dev_installed \
	ncurses-dev_installed

bc_TSL_TYPE := sw
bc_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,readline-$(readline_ABI)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI)) \
	$(call bigger_equal_dep,licenses)
bc_TSL_SRC_PKG := bc

bc-dev_TSL_TYPE := sw
bc-dev_TSL_RDEPS = \
	$(call equal_dep,bc) \
	$(call bigger_equal_dep,licenses)
bc-dev_TSL_SRC_PKG := bc

bc_TSL_PKGS := bc-dev bc

endif
