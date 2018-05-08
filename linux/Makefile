SRC_NAME := linux

include description.mk
include ../common/basic.mk

$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	cp $(PACKAGING_RESOURCE_DIR)/linux/config .config && \
	$(MAKE) olddefconfig
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	$(MAKE)
	> $@