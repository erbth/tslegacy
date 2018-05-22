SRC_NAME := llvm

include description.mk
include ../common/basic.mk

# I adapted the configure and build procedures from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
#
# Thomas Erbesdobler <t.erbesdobler@gmx.de>
$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	mkdir build && \
	cd build && \
	CC=gcc CXX=g++ cmake \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DLLVM_ENABLE_FFI=ON \
		-DCMAKE_BUILD_TYPE=Release \
		-DLLVM_BUILD_LLVM_DYLIB=ON \
		-DLLVM_TARGETS_TO_BUILD="host;AMDGPU" \
		-Wno-dev \
		..
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR)/build && \
	$(MAKE)
	> $@