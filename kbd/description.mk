ifndef kbd_description_included
kbd_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

kbd_SRC_VERSION := 2.0.4
kbd_SRC_DIR := kbd-$(kbd_SRC_VERSION)
kbd_SRC_ARCHIVE := $(kbd_SRC_DIR).tar
kbd_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

kbd_TSL_TYPE := sw
kbd_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,licenses)
kbd_TSL_SRC_PKG := kbd

kbd-dev_TSL_TYPE := sw
kbd-dev_TSL_RDEPS = \
	$(call equal_dep,kbd) \
	$(call bigger_equal_dep,licenses)
kbd-dev_TSL_SRC_PKG := kbd

kbd_TSL_PKGS := kbd-dev kbd

endif
