# The name of the source package to build
SRC_NAME := linux-headers

include description.mk
include ../common/basic.mk

# Rules for configuring and building
$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	$(MAKE) mrproper
	> $@

$(BUILD_DIR)/built:
	> $@
