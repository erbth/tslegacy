ifndef python_description_included
python_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/bzip2/description.mk
include $(PACKAGING_RESOURCE_DIR)/openssl/description.mk
include $(PACKAGING_RESOURCE_DIR)/expat/description.mk
include $(PACKAGING_RESOURCE_DIR)/libffi/description.mk
include $(PACKAGING_RESOURCE_DIR)/gdbm/description.mk
include $(PACKAGING_RESOURCE_DIR)/ncurses/description.mk
include $(PACKAGING_RESOURCE_DIR)/readline/description.mk
include $(PACKAGING_RESOURCE_DIR)/zlib/description.mk

python_SRC_VERSION := 2.7.15
python_SRC_DIR := Python-$(python_SRC_VERSION)
python_SRC_ARCHIVE := $(python_SRC_DIR).tar.xz
python_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	expat-dev_installed \
	libffi-dev_installed \
	gdbm-dev_installed \
	openssl-dev_installed \
	ncurses-dev_installed \
	readline-dev_installed \
	zlib-dev_installed \
	pkg-config-dev_installed

export libpython_ABI := 1.0

libpython-$(libpython_ABI)_TSL_TYPE := sw
libpython-$(libpython_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
libpython-$(libpython_ABI)_TSL_SRC_PKG := python

python_TSL_TYPE := sw
python_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libbz2-$(libbz2_ABI)) \
	$(call bigger_equal_dep,openssl-$(openssl_ABI)) \
	$(call bigger_equal_dep,libexpat-$(libexpat_ABI)) \
	$(call bigger_equal_dep,libffi-$(libffi_ABI)) \
	$(call bigger_equal_dep,libgdbm-compat-$(libgdbm_compat_ABI)) \
	$(call bigger_equal_dep,libgdbm-$(libgdbm_ABI)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI)) \
	$(call bigger_equal_dep,readline-$(readline_ABI)) \
	$(call bigger_equal_dep,zlib-$(zlib_ABI)) \
	$(call bigger_equal_dep,libpython-$(libpython_ABI))
python_TSL_SRC_PKG := python

python-dev_TSL_TYPE := sw
python-dev_TSL_RDEPS = \
	$(call equal_dep,libpython-$(libpython_ABI)) \
	$(call equal_dep,python)
python-dev_TSL_SRC_PKG := python

python_TSL_PKGS := python-dev python libpython-$(libpython_ABI)

endif
