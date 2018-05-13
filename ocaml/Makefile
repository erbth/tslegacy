SRC_NAME := ocaml

include description.mk
include ../common/basic.mk

$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	./configure \
		-prefix /usr \
		-mandir '$$(PREFIX)'/share/man
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	$(MAKE) world.opt
	> $@