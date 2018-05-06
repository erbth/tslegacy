SRC_NAME := sed

include description.mk
include ../common/basic.mk

# The bootscripts I currently use expect sed to be located in /bin. They are
# a fork of LFS's bootscripts, which are designed to deal with a shared /usr
# folder. For more details have a look at tslegacy-bootscripts.
$(BUILD_DIR)/configured:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	./configure --prefix=/usr \
		--bindir=/bin
	> $@

$(BUILD_DIR)/built:
	cd $(BUILD_DIR)/$(SRC_DIR) && \
	$(MAKE)
	> $@