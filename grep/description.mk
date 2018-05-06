ifndef grep_description_included
grep_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

grep_SRC_VERSION := 3.1
grep_SRC_DIR := grep-$(grep_SRC_VERSION)
grep_SRC_ARCHIVE := $(grep_SRC_DIR).tar.xz
grep_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

grep_TSL_TYPE := sw
grep_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,bash) \
	$(call bigger_equal_dep,licenses)
grep_TSL_SRC_PKG := grep

grep-dev_TSL_TYPE := sw
grep-dev_TSL_RDEPS = \
	$(call equal_dep,grep) \
	$(call bigger_equal_dep,licenses)
grep-dev_TSL_SRC_PKG := grep

grep_TSL_PKGS := grep-dev grep

endif
