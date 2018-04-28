gmp_SRC_VERSION := 6.1.2
gmp_SRC_DIR := gmp-$(gmp_SRC_VERSION)
gmp_SRC_ARCHIVE := $(gmp_SRC_DIR).tar.xz
gmp_SRC_CDEPS := binutils_installed

export gmp_ABI := 10
export gmpxx_ABI := 4

gmp-$(gmp_ABI)_TSL_TYPE := sw
gmp-$(gmp_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
gmp-$(gmp_ABI)_TSL_SRC_PKG := gmp

gmpxx-$(gmpxx_ABI)_TSL_TYPE := sw
gmpxx-$(gmpxx_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,gmp-$(gmp_ABI)) \
	$(call bigger_equal_dep,libstdc++-$(libstdc++_ABI)) \
	$(call bigger_equal_dep,libgcc-$(libgcc_ABI)) \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
gmpxx-$(gmpxx_ABI)_TSL_SRC := gmp

gmp-dev_TSL_TYPE := sw
gmp-dev_TSL_RDEPS := \
	$(call equal_dep,gmp-$(gmp_ABI)) \
	$(call equal_dep,gmpxx-$(gmpxx_ABI))
gmp-dev_TSL_SRC_PKG := gmp

gmp_TSL_PKGS := gmp-dev gmp-$(gmp_ABI) gmpxx-$(gmpxx_ABI)