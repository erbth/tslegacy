SRC_NAME := findlib

include description.mk
include ../common/basic.mk

$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	./configure \
		-mandir /usr/share/man \
		-config /etc/findlib.conf
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	$(MAKE) all && \
	$(MAKE) opt
	> $@