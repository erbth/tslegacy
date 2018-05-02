ifndef bash_description_included
bash_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/readline/description.mk
include $(PACKAGING_RESOURCE_DIR)/ncurses/description.mk

bash_SRC_VERSION := 4.4.18
bash_SRC_DIR := bash-$(bash_SRC_VERSION)
bash_SRC_ARCHIVE := $(bash_SRC_DIR).tar.gz
bash_SRC_CDEPS := \
	licenses_installed \
	glibc-dev_installed \
	gcc_installed \
	readline-dev_installed \
	ncurses-dev_installed \
	pkg-config-dev_installed

bash_TSL_TYPE := sw
bash_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,readline-$(readline_ABI)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI)) \
	$(call bigger_equal_dep,licenses)
bash_TSL_SRC_PKG := bash

bash-dev_TSL_TYPE := sw
bash-dev_TSL_RDEPS = \
	$(call equal_dep,bash) \
	$(call bigger_equal_dep,licenses)
bash-dev_TSL_SRC_PKG := bash

bash_TSL_PKGS := bash-dev bash

endif
