# Tab size: 4

SRC_NAME := basic_fhs

include description.mk
include ../common/basic.mk

$(BUILD_DIR)/configured:
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR) && $(MAKE) && > $@
	> $@
