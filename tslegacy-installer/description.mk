ifndef tslegacy-installer_description_included
tslegacy-installer_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

tslegacy-installer_SRC_VERSION := 0.0.0
tslegacy-installer_SRC_DIR := dummy_src_pkg
tslegacy-installer_SRC_ARCHIVE := dummy_src_pkg.tar.gz
tslegacy-installer_SRC_CDEPS := \
	bash_collected \
	cifs-utils_collected \
	coreutils_collected \
	e2fsprogs_collected \
	eudev_collected \
	findutils_collected \
	glibc_collected \
	grep_collected \
	grub_collected \
	gzip_collected \
	iana-etc_collected \
	inetutils_collected \
	iproute2_collected \
	isc-dhcp-client_collected \
	kbd_collected \
	kmod_collected \
	less_collected \
	linux_collected \
	ncurses_collected \
	ntfs-3g_collected \
	procps-ng_collected \
	sed_collected \
	shadow_collected \
	sysvinit_collected \
	tar_collected \
	tpm_collected \
	tslegacy-bootscripts_collected \
	tslegacy-sysconfig_collected \
	tslegacy-utils_collected \
	tzdata_collected \
	util-linux_collected \
	vim_collected

tslegacy-installer_TSL_TYPE := sw
tslegacy-installer_TSL_RDEPS = \
	$(foreach PKG,$(tslegacy-installer_SRC_CDEPS:%_collected=%),\
		$(call bigger_equal_dep,$(PKG)))
tslegacy-installer_TSL_SRC_PKG := tslegacy-installer

tslegacy-installer_TSL_PKGS := tslegacy-installer

endif
