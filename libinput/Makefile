SRC_NAME := libinput

include description.mk
include ../common/basic.mk

# I adapted the configure and build procedures from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	mkdir build && \
	cd build && \
	meson \
		--prefix=/usr \
		-Dudev-dir=/lib/udev \
		-Ddebug-gui=false \
		-Dtests=false \
		-Ddocumentation=false \
		-Dlibwacom=false \
		..
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR)/build && \
	ninja
	> $@