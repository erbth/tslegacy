ifndef tslegacy-compiletime_description_included
tslegacy-compiletime_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# The collection of packages follows the toolchain described in the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.
tslegacy-compiletime_SRC_VERSION := 0.0.0
tslegacy-compiletime_SRC_DIR := dummy_src_pkg
tslegacy-compiletime_SRC_ARCHIVE := dummy_src_pkg.tar.gz
tslegacy-compiletime_SRC_CDEPS := \
	bash_collected \
	cifs-utils_collected \
	coreutils_collected \
	e2fsprogs_collected \
	eudev_collected \
	glibc_collected \
	grub_collected \
	iana-etc_collected \
	inetutils_collected \
	kbd_collected \
	kmod_collected \
	linux_collected \
	ncurses_collected \
	procps-ng_collected \
	shadow_collected \
	sysvinit_collected \
	toolchain_collected \
	tpm_collected \
	tslegacy-bootscripts_collected \
	tslegacy-config_collected \
	tslegacy-sysconfig_collected \
	tslegacy-utils_collected \
	tzdata_collected \
	util-linux_collected \
	vim_collected

tslegacy-compiletime_TSL_TYPE := sw
tslegacy-compiletime_TSL_RDEPS = \
	$(foreach PKG,$(tslegacy-compiletime_SRC_CDEPS:%_collected=%),\
		$(call bigger_equal_dep,$(PKG)))
tslegacy-compiletime_TSL_SRC_PKG := tslegacy-compiletime

tslegacy-compiletime_TSL_PKGS := tslegacy-compiletime

endif
