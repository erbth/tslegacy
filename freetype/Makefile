SRC_NAME := freetype

include description.mk
include ../common/basic.mk

ifdef WITHOUT_HARFBUZZ
freetype_CONFIG_HARFBUZZ := --with-harfbuzz=no
endif

# I adapted the configure and build procedures from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	./configure \
		--prefix=/usr \
		--disable-static $(freetype_CONFIG_HARFBUZZ)
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	$(MAKE)
	> $@