SRC_NAME := xf86-input-vmmouse

include description.mk
include ../common/basic.mk
include ../utils/xorg/build_env.mk

# I adapted the configure and build procedures from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	./configure \
		$(XORG_CONFIG) \
		--without-hal-fdi-dir \
		--without-hal-callouts-dir \
		--with-udev-rules-dir=/lib/udev/rules.d
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	$(MAKE)
	> $@