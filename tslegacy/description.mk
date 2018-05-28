ifndef tslegacy_description_included
tslegacy_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# Packages of Xorg that are included in tslegacy
tslegacy_XORG_PACKAGES := \
	xrandr \
	xbacklight \
	xhost \
	xlsclients \
	xrdb \
	xclock \
	xcursor-themes \
	xorg-fonts \
	fontconfig \
	xkeyboard-config \
	xorg-server \
	xf86-input-libinput \
	xf86-input-synaptics \
	xf86-input-vmmouse \
	xf86-input-wacom \
	xf86-video-amdgpu \
	xf86-video-ati \
	xf86-video-fbdev \
	xf86-video-intel \
	xf86-video-nouveau \
	xf86-video-vmware \
	xinit

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
	vim_collected \
	$(tslegacy_XORG_PACKAGES:%=%_collected)

tslegacy_TSL_TYPE := sw
tslegacy_TSL_RDEPS = \
	$(foreach PKG,$(tslegacy_SRC_CDEPS:%_collected=%),\
		$(call bigger_equal_dep,$(PKG)))
tslegacy_TSL_SRC_PKG := tslegacy

tslegacy_TSL_PKGS := tslegacy

endif
