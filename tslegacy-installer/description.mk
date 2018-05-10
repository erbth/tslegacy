ifndef tslegacy-installer_description_included
tslegacy-installer_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

tslegacy-installer_SRC_VERSION := 0.0.0
tslegacy-installer_SRC_DIR := dummy_src_pkg
tslegacy-installer_SRC_ARCHIVE := dummy_src_pkg.tar.gz
tslegacy-installer_SRC_CDEPS :=

tslegacy-installer_TSL_TYPE := sw
tslegacy-installer_TSL_RDEPS = \
	$(call bigger_equal_dep,bash) \
	$(call bigger_equal_dep,cifs-utils) \
	$(call bigger_equal_dep,coreutils) \
	$(call bigger_equal_dep,e2fsprogs) \
	$(call bigger_equal_dep,eudev) \
	$(call bigger_equal_dep,findutils) \
	$(call bigger_equal_dep,glibc) \
	$(call bigger_equal_dep,grep) \
	$(call bigger_equal_dep,grub) \
	$(call bigger_equal_dep,gzip) \
	$(call bigger_equal_dep,iana-etc) \
	$(call bigger_equal_dep,inetutils) \
	$(call bigger_equal_dep,iproute2) \
	$(call bigger_equal_dep,isc-dhcp-client) \
	$(call bigger_equal_dep,kbd) \
	$(call bigger_equal_dep,kmod) \
	$(call bigger_equal_dep,less) \
	$(call bigger_equal_dep,linux) \
	$(call bigger_equal_dep,ncurses) \
	$(call bigger_equal_dep,procps-ng) \
	$(call bigger_equal_dep,sed) \
	$(call bigger_equal_dep,shadow) \
	$(call bigger_equal_dep,sysvinit) \
	$(call bigger_equal_dep,tar) \
	$(call bigger_equal_dep,tpm) \
	$(call bigger_equal_dep,tslegacy-bootscripts) \
	$(call bigger_equal_dep,tslegacy-sysconfig) \
	$(call bigger_equal_dep,tslegacy-utils) \
	$(call bigger_equal_dep,tzdata) \
	$(call bigger_equal_dep,util-linux) \
	$(call bigger_equal_dep,vim)
tslegacy-installer_TSL_SRC_PKG := tslegacy-installer

tslegacy-installer_TSL_PKGS := tslegacy-installer

endif
