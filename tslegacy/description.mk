ifndef tslegacy_description_included
tslegacy_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

tslegacy_SRC_VERSION := 0.0.0
tslegacy_SRC_DIR := dummy_src_pkg
tslegacy_SRC_ARCHIVE := dummy_src_pkg.tar.gz
tslegacy_SRC_CDEPS :=

tslegacy_TSL_TYPE := sw
tslegacy_TSL_RDEPS = \
	$(call bigger_equal_dep,bash) \
	$(call bigger_equal_dep,cifs-utils) \
	$(call bigger_equal_dep,coreutils) \
	$(call bigger_equal_dep,eudev) \
	$(call bigger_equal_dep,glibc) \
	$(call bigger_equal_dep,grub) \
	$(call bigger_equal_dep,iana-etc) \
	$(call bigger_equal_dep,inetutils) \
	$(call bigger_equal_dep,kbd) \
	$(call bigger_equal_dep,kmod) \
	$(call bigger_equal_dep,linux) \
	$(call bigger_equal_dep,ncurses) \
	$(call bigger_equal_dep,ntfs-3g) \
	$(call bigger_equal_dep,procps-ng) \
	$(call bigger_equal_dep,shadow) \
	$(call bigger_equal_dep,sysvinit) \
	$(call bigger_equal_dep,tpm) \
	$(call bigger_equal_dep,tslegacy-bootscripts) \
	$(call bigger_equal_dep,tslegacy-sysconfig) \
	$(call bigger_equal_dep,tslegacy-utils) \
	$(call bigger_equal_dep,tzdata) \
	$(call bigger_equal_dep,util-linux) \
	$(call bigger_equal_dep,vim)
tslegacy_TSL_SRC_PKG := tslegacy

tslegacy_TSL_PKGS := tslegacy

endif
