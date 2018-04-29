ifndef glibc_description_included
glibc_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# Information about the source package itself
glibc_SRC_VERSION := 2.27
glibc_SRC_ARCHIVE := glibc-$(glibc_SRC_VERSION).tar.xz
glibc_SRC_DIR := glibc-$(glibc_SRC_VERSION)
glibc_SRC_CDEPS := \
	basic_fhs-dev_installed \
	linux-headers-dev_installed \
	licenses_installed

# Information about the differrent packages that are built out of this source
# package.
glibc-dev_TSL_TYPE := sw
glibc-dev_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	glibc=$(call read_version,glibc)
glibc-dev_TSL_SRC_PKG := glibc

glibc_TSL_TYPE := sw
glibc_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
glibc_TSL_SRC_PKG := glibc

glibc-$(glibc_SRC_VERSION)_TSL_TYPE := sw
glibc-$(glibc_SRC_VERSION)_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs) \
	$(call bigger_equal_dep,ld-linux-2) \
	$(call bigger_equal_dep,ld-lsb-3) \
	$(call bigger_equal_dep,libanl-1) \
	$(call bigger_equal_dep,libBrokenLocale-1) \
	$(call bigger_equal_dep,libcidn-1) \
	$(call bigger_equal_dep,libcrypt-1) \
	$(call bigger_equal_dep,libc-6) \
	$(call bigger_equal_dep,libdl-2) \
	$(call bigger_equal_dep,libmemusage-o) \
	$(call bigger_equal_dep,libm-6) \
	$(call bigger_equal_dep,libmvec-1) \
	$(call bigger_equal_dep,libnsl-1) \
	$(call bigger_equal_dep,libnss_compat-2) \
	$(call bigger_equal_dep,libnss_db-2) \
	$(call bigger_equal_dep,libnss_dns-2) \
	$(call bigger_equal_dep,libnss_files-2) \
	$(call bigger_equal_dep,libnss_hesiod-2) \
	$(call bigger_equal_dep,libpcprofile-o) \
	$(call bigger_equal_dep,libpthread-0) \
	$(call bigger_equal_dep,libresolv-2) \
	$(call bigger_equal_dep,librt-1) \
	$(call bigger_equal_dep,libSegFault-o) \
	$(call bigger_equal_dep,libthread_db-1) \
	$(call bigger_equal_dep,libutil-1) \
	$(call bigger_equal_dep,sotruss-lib-o) \
	$(call bigger_equal_dep,locales-dev)
glibc-$(glibc_SRC_VERSION)_TSL_SRC_PKG := glibc

ld-linux-2_TSL_TYPE := sw
ld-linux-2_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
ld-linux-2_TSL_SRC_PKG := glibc

ld-lsb-3_TSL_TYPE := sw
ld-lsb-3_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs) \
	$(call bigger_equal_dep,ld-linux-2)
ld-lsb-3_TSL_SRC_PKG := glibc

libanl-1_TSL_TYPE := sw
libanl-1_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libanl-1_TSL_SRC_PKG := glibc

libBrokenLocale-1_TSL_TYPE := sw
libBrokenLocale-1_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libBrokenLocale-1_TSL_SRC_PKG := glibc

libcidn-1_TSL_TYPE := sw
libcidn-1_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libcidn-1_TSL_SRC_PKG := glibc

libcrypt-1_TSL_TYPE := sw
libcrypt-1_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libcrypt-1_TSL_SRC_PKG := glibc

libc-6_TSL_TYPE := sw
libc-6_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libc-6_TSL_SRC_PKG := glibc

libdl-2_TSL_TYPE := sw
libdl-2_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libdl-2_TSL_SRC_PKG := glibc

libmemusage-o_TSL_TYPE := sw
libmemusage-o_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libmemusage-o_TSL_SRC_PKG := glibc

libm-6_TSL_TYPE := sw
libm-6_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libm-6_TSL_SRC_PKG := glibc

libmvec-1_TSL_TYPE := sw
libmvec-1_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libmvec-1_TSL_SRC_PKG := glibc

libnsl-1_TSL_TYPE := sw
libnsl-1_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libnsl-1_TSL_SRC_PKG := glibc

libnss_compat-2_TSL_TYPE := sw
libnss_compat-2_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libnss_compat-2_TSL_SRC_PKG := glibc

libnss_db-2_TSL_TYPE := sw
libnss_db-2_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libnss_db-2_TSL_SRC_PKG := glibc

libnss_dns-2_TSL_TYPE := sw
libnss_dns-2_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libnss_dns-2_TSL_SRC_PKG := glibc

libnss_files-2_TSL_TYPE := sw
libnss_files-2_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libnss_files-2_TSL_SRC_PKG := glibc

libnss_hesiod-2_TSL_TYPE := sw
libnss_hesiod-2_TSL_RDEPS = \
	$(call bigger_equal_version,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libnss_hesiod-2_TSL_SRC_PKG := glibc

libpcprofile-o_TSL_TYPE := sw
libpcprofile-o_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libpcprofile-o_TSL_SRC_PKG := glibc

libpthread-0_TSL_TYPE := sw
libpthread-0_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libpthread-0_TSL_SRC_PKG := glibc

libresolv-2_TSL_TYPE := sw
libresolv-2_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libresolv-2_TSL_SRC_PKG := glibc

librt-1_TSL_TYPE := sw
librt-1_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
librt-1_TSL_SRC_PKG := glibc

libSegFault-o_TSL_TYPE := sw
libSegFault-o_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libSegFault-o_TSL_SRC_PKG := glibc

libthread_db-1_TSL_TYPE := sw
libthread_db-1_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libthread_db-1_TSL_SRC_PKG := glibc

libutil-1_TSL_TYPE := sw
libutil-1_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
libutil-1_TSL_SRC_PKG := glibc

sotruss-lib-o_TSL_TYPE := sw
sotruss-lib-o_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
sotruss-lib-o_TSL_SRC_PKG := glibc

locales-dev_TSL_TYPE := sw
locales-dev_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses) \
	$(call bigger_equal_dep,basic_fhs)
locales-dev_TSL_SRC_PKG := glibc


# A list of all the packages that are built out of this source package
glibc_TSL_PKGS := \
	glibc-dev \
	glibc \
	glibc-$(glibc_SRC_VERSION) \
	ld-linux-2 \
	ld-lsb-3 \
	libanl-1 \
	libBrokenLocale-1 \
	libcidn-1 \
	libcrypt-1 \
	libc-6 \
	libdl-2 \
	libmemusage-o \
	libm-6 \
	libmvec-1 \
	libnsl-1 \
	libnss_compat-2 \
	libnss_db-2 \
	libnss_dns-2 \
	libnss_files-2 \
	libnss_hesiod-2 \
	libpcprofile-o \
	libpthread-0 \
	libresolv-2 \
	librt-1 \
	libSegFault-o \
	libthread_db-1 \
	libutil-1 \
	sotruss-lib-o \
	locales-dev

endif
