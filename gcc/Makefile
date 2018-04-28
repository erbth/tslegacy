SRC_PKG := gcc

include description.mk
include ../common/basic.mk

# The build and configure procedures were adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.
$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	mkdir -p build && \
	cd build && \
	eval SED=sed && \
	../configure \
		--prefix=/usr \
		--enable-languages=c,c++ \
		--disable-multilib \
		--disable-bootstrap \
		--enable-libssp \
		--with-system-zlib
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR)/build && \
	$(MAKE)
	> $@
