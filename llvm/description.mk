ifndef llvm_description_included
llvm_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# I concluded the compiletime dependencies from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
llvm_SRC_VERSION := 6.0.0
llvm_SRC_DIR := llvm-$(llvm_SRC_VERSION).src
llvm_SRC_ARCHIVE := $(llvm_SRC_DIR).tar.xz
llvm_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	libxml2-dev_installed \
	python-dev_installed \
	cmake_installed \
	ocaml-dev_installed \
	ocamlbuild-dev_installed \
	libffi-dev_installed \
	icu-dev_installed \
	xz-dev_installed \
	zlib-dev_installed \
	ncurses-dev_installed

llvm-libs_TSL_TYPE := sw
llvm-libs_TSL_RDEPS =
llvm-libs_TSL_SRC_PKG := llvm

llvm_TSL_TYPE := sw
llvm_TSL_RDEPS = \
	$(call bigger_equal_dep,llvm-libs)
llvm_TSL_SRC_PKG := llvm

llvm-dev_TSL_TYPE := sw
llvm-dev_TSL_RDEPS = \
	$(call equal_dep,llvm) \
	$(call equal_dep,llvm-libs)
llvm-dev_TSL_SRC_PKG := llvm

llvm_TSL_PKGS := llvm-dev llvm llvm-libs

endif
