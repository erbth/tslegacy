ifndef tslegacy_description_included
tslegacy_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

tslegacy_SRC_VERSION := 0.0.0
tslegacy_SRC_DIR := dummy_src_pkg
tslegacy_SRC_ARCHIVE := dummy_src_pkg.tar.gz
tslegacy_SRC_CDEPS := \
	alsa-lib_collected \
	alsa-utils_collected \
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
	ntfs-3g_collected \
	procps-ng_collected \
	shadow_collected \
	sysvinit_collected \
	tpm_collected \
	tslegacy-bootscripts_collected \
	tslegacy-config_collected \
	tslegacy-sysconfig_collected \
	tslegacy-utils_collected \
	tzdata_collected \
	util-linux_collected \
	vim_collected

tslegacy_TSL_TYPE := sw
tslegacy_TSL_RDEPS = \
	$(foreach PKG,$(tslegacy_SRC_CDEPS:%_collected=%),\
		$(call bigger_equal_dep,$(PKG)))
tslegacy_TSL_SRC_PKG := tslegacy

tslegacy_TSL_PKGS := tslegacy

endif
