ifndef perl_description_included
perl_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/zlib/description.mk
include $(PACKAGING_RESOURCE_DIR)/bzip2/description.mk
include $(PACKAGING_RESOURCE_DIR)/gdbm/description.mk

# The book `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing
# Editor Bruce Dubbs suggests on page 151 that /etc/hosts must be in place when
# building perl therefore I added the dependency on tslegacy-sysconfig. At the
# time I initially wrote this file, the book was available from
# www.linuxfromscratch.org/lfs.
perl_SRC_VERSION := 5.26.1
perl_SRC_DIR := perl-$(perl_SRC_VERSION)
perl_SRC_ARCHIVE := $(perl_SRC_DIR).tar.gz
perl_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	tslegacy-sysconfig_installed \
	zlib-dev_installed \
	bzip2-dev_installed \
	gdbm-dev_installed

export perl_ABI := $(perl_SRC_VERSION)

perl_TSL_TYPE := sw
perl_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,perl-$(perl_ABI)) \
	$(call bigger_equal_dep,licenses)
perl_TSL_SRC_PKG := perl

perl-$(perl_ABI)_TSL_TYPE := sw
perl-$(perl_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libbz2-$(libbz2_ABI)) \
	$(call bigger_equal_dep,zlib-$(zlib_ABI)) \
	$(call bigger_equal_dep,libgdbm-compat-$(libgdbm_compat_ABI)) \
	$(call bigger_equal_dep,libgdbm-$(libgdbm_ABI)) \
	$(call bigger_equal_dep,licenses)
perl-$(perl_ABI)_TSL_SRC_PKG := perl

perl-dev_TSL_TYPE := sw
perl-dev_TSL_RDEPS = \
	$(call equal_dep,perl-$(perl_ABI)) \
	$(call equal_dep,perl) \
	$(call bigger_equal_dep,licenses)
perl-dev_TSL_SRC_PKG := perl

perl_TSL_PKGS := perl-dev perl-$(perl_ABI) perl

endif
