# The name of the source package to build
SRC_NAME := linux-headers

include description.mk
include ../common/basic.mk

# Rules for configuring and building
linux-headers_configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	$(MAKE) mrproper
	> $@

linux-headers_built:
	> $@
