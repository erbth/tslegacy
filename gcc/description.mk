# Include required dependency information
include ../glibc/description.mk

# Information about the source package itself
gcc_SRC_VERSION := 7.3.0
gcc_SRC_DIR := gcc-$(gcc_SRC_VERSION)
gcc_SRC_ARCHIVE := $(gcc_SRC_DIR).tar.xz
gcc_SRC_CDEPS := gmp-dev_installed mpfr-dev_installed mpc-dev_installed

# ABI versions
libasan_ABI			= 4
libatomic_ABI		= 1
libcc1_ABI			= 0
libcilkrts_ABI		= 5
libgcc_ABI			= 1
libgomp_ABI			= 1
libitm_ABI			= 1
liblsan_ABI			= 0
libmpx_ABI			= 2
libmpxwrappers_ABI	= 2
libquadmath_ABI		= 0
libssp_ABI			= 0
libstdc++_ABI		= 6
libtsan_ABI			= 0
libubsan_ABI		= 0

# Information about the TSL packages that are built out of this source package
gcc_TSL_TYPE := sw
gcc_TSL_RDEPS := \
	$(call equal_dep,libasan-$(libasan_ABI)) \
	$(call equal_dep,libatomic-$(libatomic_ABI)) \
	$(call equal_dep,libcc1-$(libcc1_ABI)) \
	$(call equal_dep,libcilkrts-$(libcilkrts_ABI)) \
	$(call equal_dep,libgcc-$(libgcc_ABI)) \
	$(call equal_dep,libgomp-$(libgomp_ABI)) \
	$(call equal_dep,libitm-$(libitm_ABI)) \
	$(call equal_dep,liblsan-$(liblsan_ABI)) \
	$(call equal_dep,libmpx-$(libmpx_ABI)) \
	$(call equal_dep,libmpxwrappers-$(libmpxwrappers_ABI)) \
	$(call equal_dep,libquadmath-$(libquadmath_ABI)) \
	$(call equal_dep,libssp-$(libssp_ABI)) \
	$(call equal_dep,libstdc++-$(libstdc++_ABI)) \
	$(call equal_dep,libtsan-$(libtsan_ABI)) \
	$(call equal_dep,libubsan-$(libubsan_ABI)) \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,gmp-$(gmp_ABI)) \
	$(call bigger_equal_dep,mpc-$(mpc_ABI)) \
	$(call bigger_equal_dep,mpfr-$(mpfr_ABI)) \
	$(call bigger_equal_dep,zlib-$(zlib_ABI))
gcc_TSL_SRC_PKG := gcc


# The different ABI versioned libraries
libasan-$(libasan_ABI)_TSL_TYPE := sw
libasan-$(libasan_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI)) \
	$(call bigger_equal_dep,libstdc++-$(libstdc++_ABI))
libasan-$(libasan_ABI)_TSL_SRC_PKG := gcc


libatomic-$(libatomic_ABI)_TSL_TYPE := sw
libatomic-$(libatomic_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
libatomic-$(libatomic_ABI)_TSL_SRC_PKG := gcc

libcc1-$(libcc1_ABI)_TSL_TYPE := sw
libcc1-$(libcc1_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libstdc++-$(libstdc++_ABI))
libcc1-$(libcc1_ABI)_TSL_SRC_PKG := gcc

libcilkrts-$(libcilkrts_ABI)_TSL_TYPE := sw
libcilkrts-$(libcilkrts_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI))
libcilkrts-$(libcilkrts_ABI)_TSL_SRC_PKG := gcc

libgcc-$(libgcc_ABI)_TSL_TYPE := sw
libgcc-$(libgcc_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
libgcc-$(libgcc_ABI)_TSL_SRC_PKG := gcc

libgomp-$(libgomp_ABI)_TSL_TYPE := sw
libgomp-$(libgomp_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI))
libgomp-$(libgomp_ABI)_TSL_SRC_PKG := gcc

libitm-$(libitm_ABI)_TSL_TYPE := sw
libitm-$(libitm_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
libitm-$(libitm_ABI)_TSL_SRC_PKG := gcc

liblsan-$(liblsan_ABI)_TSL_TYPE := sw
liblsan-$(liblsan_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI)) \
	$(call bigger_equal_dep,libstdc++-$(libstdc++_ABI))
liblsan-$(liblsan_ABI)_TSL_SRC_PKG := gcc

libmpx-$(libmpx_ABI)_TSL_TYPE := sw
libmpx-$(libmpx_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
libmpx-$(libmpx_ABI)_TSL_SRC_PKG := gcc

libmpxwrappers-$(libmpxwrappers_ABI)_TSL_TYPE := sw
libmpxwrappers-$(libmpxwrappers_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
libmpxwrappers-$(libmpxwrappers_ABI)_TSL_SRC_PKG := gcc

libquadmath-$(libquadmath_ABI)_TSL_TYPE := sw
libquadmath-$(libquadmath_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
libquadmath-$(libquadmath_ABI)_TSL_SRC_PKG := gcc

libssp-$(libssp_ABI)_TSL_TYPE := sw
libssp-$(libssp_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
libssp-$(libssp_ABI)_TSL_SRC_PKG := gcc

libstdc++-$(libstdc++_ABI)_TSL_TYPE := sw
libstdc++-$(libstdc++_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI))
libstdc++-$(libstdc++_ABI)_TSL_SRC_PKG := gcc

libtsan-$(libtsan_ABI)_TSL_TYPE := sw
libtsan-$(libtsan_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI)) \
	$(call bigger_equal_dep,libstdc++-$(libstdc++_ABI))
libtsan-$(libtsan_ABI)_TSL_SRC_PKG := gcc

libubsan-$(libubsan_ABI)_TSL_TYPE := sw
libubsan-$(libubsan_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI)) \
	$(call bigger_equal_dep,libstdc++-$(libstdc++_ABI))
libubsan-$(libubsan_ABI)_TSL_SRC_PKG := gcc


# A list of TSL pacakges that are built out of this source package
export gcc_TSL_PKGS := \
	libasan-$(libasan_ABI) \
	libatomic-$(libatomic_ABI) \
	libcc1-$(libcc1_ABI) \
	libcilkrts-$(libcilkrts_ABI) \
	libgcc-$(libgcc_ABI) \
	libgomp-$(libgomp_ABI) \
	libitm-$(libitm_ABI) \
	liblsan-$(liblsan_ABI) \
	libmpx-$(libmpx_ABI) \
	libmpxwrappers-$(libmpxwrappers_ABI) \
	libquadmath-$(libquadmath_ABI) \
	libssp-$(libssp_ABI) \
	libstdc++-$(libstdc++_ABI) \
	libtsan-$(libtsan_ABI) \
	libubsan-$(libubsan_ABI) \
	gcc