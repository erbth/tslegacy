ifndef vim_description_included
vim_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

include $(PACKAGING_RESOURCE_DIR)/glibc/description.mk
include $(PACKAGING_RESOURCE_DIR)/ncurses/description.mk

export vim_SRC_VERSION := 8.0.586
vim_SRC_DIR := vim80
vim_SRC_ARCHIVE := vim-$(vim_SRC_VERSION).tar.bz2
vim_SRC_CDEPS := \
	gcc_installed \
	ncurses-dev_installed

vim_TSL_TYPE := sw
vim_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI))
vim_TSL_SRC_PKG := vim

vim-dev_TSL_TYPE := sw
vim-dev_TSL_RDEPS = \
	$(call equal_dep,vim)
vim-dev_TSL_SRC_PKG := vim

vim_TSL_PKGS := vim-dev vim

endif
