SRC_PKG := gmp

include description.mk
include ../common/basic.mk

$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	./configure \
		--prefix=/usr \
		--enable-cxx \
		--disable-static
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	$(MAKE) && \
	$(MAKE) html
	> $@