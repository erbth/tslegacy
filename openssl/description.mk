ifndef openssl_description_included
openssl_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk

openssl_SRC_VERSION := 1.1.0h
openssl_SRC_DIR := openssl-$(openssl_SRC_VERSION)
openssl_SRC_ARCHIVE := $(openssl_SRC_DIR).tar.gz
openssl_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	zlib-dev_installed

export openssl_ABI := 1.1

openssl-$(openssl_ABI)_TSL_TYPE := sw
openssl-$(openssl_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,zlib-$(zlib_ABI))
openssl-$(openssl_ABI)_TSL_SRC_PKG := openssl

openssl_TSL_TYPE := sw
openssl_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,zlib-$(zlib_ABI)) \
	$(call bigger_equal_dep,openssl-$(openssl_ABI))
openssl_TSL_SRC_PKG := openssl

openssl-dev_TSL_TYPE := sw
openssl-dev_TSL_RDEPS = \
	$(call equal_dep,openssl-$(openssl_ABI)) \
	$(call equal_dep,openssl)
openssl-dev_TSL_SRC_PKG := openssl

openssl_TSL_PKGS := openssl-dev openssl-$(openssl_ABI) openssl

endif
