ifndef gzip_description_included
gzip_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

gzip_SRC_VERSION := 1.9
gzip_SRC_DIR := gzip-$(gzip_SRC_VERSION)
gzip_SRC_ARCHIVE := $(gzip_SRC_DIR).tar.xz
gzip_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed

gzip_TSL_TYPE := sw
gzip_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,bash) \
	$(call bigger_equal_dep,licenses)
gzip_TSL_SRC_PKG := gzip

gzip-dev_TSL_TYPE := sw
gzip-dev_TSL_RDEPS = \
	$(call equal_dep,gzip) \
	$(call bigger_equal_dep,licenses)
gzip-dev_TSL_SRC_PKG := gzip

gzip_TSL_PKGS := gzip-dev gzip

endif
