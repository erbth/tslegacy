# The source package's name
SRC_PKG := zlib

include description.mk
include ../common/basic.mk

# Rules for configuring and building the package
$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	./configure --prefix=/usr
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	$(MAKE)
	> $@
	