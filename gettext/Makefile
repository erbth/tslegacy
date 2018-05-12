SRC_NAME := gettext

include description.mk
include ../common/basic.mk

# The build and configure procedures were adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.
$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR)/gettext-tools && \
	EMACS="no" ./configure \
		--prefix=/usr \
		--disable-shared
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR)/gettext-tools && \
	$(MAKE) -C gnulib-lib && \
	$(MAKE) -C intl pluralx.c && \
	$(MAKE) -C src msgfmt && \
	$(MAKE) -C src msgmerge && \
	$(MAKE) -C src xgettext
	> $@