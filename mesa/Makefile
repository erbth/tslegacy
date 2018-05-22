SRC_NAME := mesa

include description.mk
include ../common/basic.mk
include ../utils/xorg/build_env.mk

# I adapted the configure and build procedures from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
#
# The book indicates that there may be patent issues with floating point
# textures. Thus I disable them.
#
# Thomas Erbesdobler <t.erbesdobler@gmx.de>
$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	./configure CFLAGS='-O2' CXXFLAGS='-O2' LDFLAGS='-lLLVM' \
		--prefix=$(XORG_PREFIX) \
		--sysconfdir=/etc \
		--disable-texture-float \
		--enable-osmesa \
		--enable-xa \
		--enable-glx-tls \
		--with-platforms="drm,x11,wayland" \
		--with-gallium-drivers="i915,r300,r600,nouveau,radeonsi,svga,swrast"
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	$(MAKE)
	> $@