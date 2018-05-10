SRC_NAME := inetutils

include description.mk
include ../common/basic.mk

# The build and configure procedures were adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.=
$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	./configure \
		--prefix=/usr \
		--localstatedir=/var \
		--disable-logger \
		--disable-whois \
		--disable-rcp \
		--disable-rexec \
		--disable-rlogin \
		--disable-rsh \
		--disable-servers
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	$(MAKE)
	> $@