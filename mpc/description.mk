include ../mpfr/description.mk
include ../gmp/description.mk
include ../glibc/description.mk

mpc_SRC_VERSION := 1.1.0
mpc_SRC_DIR := mpc-$(mpc_SRC_VERSION)
mpc_SRC_ARCHIVE := $(mpc_SRC_DIR).tar.gz
mpc_SRC_CDEPS := mpfr-dev_installed

export mpc_ABI := 3

mpc-$(mpc_ABI)_TSL_TYPE := sw
mpc-$(mpc_ABI)_TSL_RDEPS := \
	$(call bigger_equal_dep,mpfr-$(mpfr_ABI)) \
	$(call bigger_equal_dep,gmp-$(gmp_ABI)) \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION))
mpc-$(mpc_ABI)_TSL_SRC_PKG := mpc

mpc-dev_TSL_TYPE := sw
mpc-dev_TSL_RDEPS := \
	$(call equal_dep,mpc-$(mpc_ABI))
mpc-dev_TSL_SRC_PKG := mpc

mpc_TSL_PKGS := mpc-$(mpc_ABI) mpc-dev