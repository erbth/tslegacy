# Tab size: 4

SRC_NAME := glibc

include description.mk
include ../common/basic.mk

# The configure procedure has been adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.
$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	mkdir -pv build && cd build && \
	GCC_VERSION=$(gcc --version|head -1|rev|cut -d ' ' -f 2|rev) && \
	case $$(uname -m) in \
		i?86)   GCC_INCDIR=/usr/lib/gcc/$$(uname -m)-pc-linux-gnu/$(GCC_VERSION)/include;; \
		x86_64) GCC_INCDIR=/usr/lib/gcc/x86_64-pc-linux-gnu/$(GCC_VERSION)/include;; \
		*) false;; \
	esac && \
	CC="gcc -isystem $$GCC_INCDIR -isystem /usr/include" && \
	../configure \
		--prefix=/usr \
		--disable-werror \
		--enable-kernel=3.2 \
		--enable-stack-protector=strong \
		libc_cv_slibdir=/lib
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR)/build && $(MAKE)
	> $@
