SRC_NAME := glib

include description.mk
include ../common/basic.mk

# I adapted the configure and build procedures from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	mkdir build-glib && \
	cd build-glib && \
	meson \
		--prefix=/usr \
		-Dinternal_pcre=false \
		-Dselinux=false \
		..
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR)/build-glib && \
	ninja
	> $@