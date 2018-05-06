# # Packages to build
# # <package name>-<version triple>
# NORMAL_PKGS := \
# 		alsa-lib \
# 		alsa-utils \
# 		amhello \
# 		bash \
# 		basic_fhs \
# 		bc \
# 		binutils \
# 		cifs-utils \
# 		e2fsprogs \
# 		elfutils \
# 		eudev \
# 		expat \
# 		file \
# 		findutils \
# 		gdbm \
# 		glibc \
# 		grep \
# 		grub \
# 		gmp \
# 		gzip \
# 		iana-etc \
# 		iproute2 \
# 		isc-dhcp-client \
# 		kbd \
# 		kmod \
# 		less \
# 		talloc \
# 		tslegacy-bootscripts \
# 		libffi \
# 		linux \
# 		linux-headers \
# 		mpc \
# 		mpfr \
# 		ncurses \
# 		ntfs-3g \
# 		openssl \
# 		pkg-config \
# 		procps-ng \
# 		python \
# 		python3 \
# 		readline \
# 		sed \
# 		shadow \
# 		sysvinit \
# 		tar \
# 		tpm \
# 		tslegacy-installer \
# 		tslegacy-sysconfig \
# 		tslegacy-utils \
# 		tzdata \
# 		util-linux \
# 		vim \
# 		zlib
#
# # GCC and associated libraries
# GCC_LIBS :=	libgcc \
# 			libstdc++ \
# 			libmpx \
# 			libvtv \
# 			libssp \
# 			libatomic \
# 			libquadmath
#
# GCC_AND_LIBS := gcc $(GCC_LIBS)
#
# GCC_SUBDIRS :=	gcc \
# 				libgcc \
# 				libstdc++ \
# 				libmpx \
# 				libvtv \
# 				libssp \
# 				libatomic \
# 				libquadmath
#
# # Dependencies between package builds, and other targets.
# $(call built_of_normal_pkg,linux): gcc_installed \
# 	bc_installed openssl_installed elfutils_installed
#
# # The packages below depend on util linux to simplify the dependency graph.
# $(call built_of_normal_pkg,alsa-utils): alsa-lib_installed
# $(call built_of_normal_pkg,alsa-lib): util-linux_installed
# $(call built_of_normal_pkg,ntfs-3g): util-linux_installed
# $(call built_of_normal_pkg,isc-dhcp-client): util-linux_installed file_installed
#
# $(call built_of_normal_pkg,cifs-utils): talloc_installed
# $(call built_of_normal_pkg,talloc): python_installed
# $(call built_of_normal_pkg,python3): libffi_installed expat_installed \
# 	gdbm_installed ncurses_installed
#
# $(call built_of_normal_pkg,python): libffi_installed expat_installed \
# 	gdbm_installed ncurses_installed
#
# $(call built_of_normal_pkg,e2fsprogs): util-linux_installed
# $(call built_of_normal_pkg,tslegacy-utils): util-linux_installed
# $(call built_of_normal_pkg,vim): ncurses_installed
# $(call built_of_normal_pkg,tpm): glibc_installed
#
# # Not each of the following packages may depend on coreutils however this
# # dependency lowers the complexity of the dependency graph and as this
# # Makefile is not parallel it is no performance issue.
# $(call built_of_normal_pkg,tslegacy-installer): coreutils_installed
# $(call built_of_normal_pkg,file): coreutils_installed zlib_installed
# $(call built_of_normal_pkg,gdbm): coreutils_installed
# $(call built_of_normal_pkg,libffi): coreutils_installed
# $(call built_of_normal_pkg,expat): coreutils_installed
# $(call built_of_normal_pkg,tslegacy-bootscripts): coreutils_installed \
#	sed_installed grep_installed findutils_installed bash_installed
# $(call built_of_normal_pkg,findutils): coreutils_installed
# $(call built_of_normal_pkg,grep): coreutils_installed
$(call built_of_normal_pkg,sed): coreutils_installed
$(call built_of_normal_pkg,tar): coreutils_installed
$(call built_of_normal_pkg,gzip): coreutils_installed
$(call built_of_normal_pkg,elfutils): coreutils_installed
$(call built_of_normal_pkg,util-linux): eudev_installed ncurses_installed
$(call built_of_normal_pkg,eudev): coreutils_installed \
	tslegacy-sysconfig_installed

$(call built_of_normal_pkg,sysvinit): coreutils_installed \
	tslegacy-sysconfig_installed

$(call built_of_normal_pkg,kbd): coreutils_installed
$(call built_of_normal_pkg,less): coreutils_installed
$(call built_of_normal_pkg,grub): coreutils_installed

# # Same thing here however with ncurses
# # Dependency on shadow according to LFS, dropped now.
$(call built_of_normal_pkg,coreutils): ncurses_installed shadow_installed
$(call built_of_normal_pkg,procps-ng): ncurses_installed
$(call built_of_normal_pkg,openssl): ncurses_installed
$(call built_of_normal_pkg,kmod): ncurses_installed
$(call built_of_normal_pkg,bash): ncurses_installed readline_installed
$(call built_of_normal_pkg,iana-etc): ncurses_installed
$(call built_of_normal_pkg,shadow): ncurses_installed \
	tslegacy-sysconfig_installed ( sed_installed ?? )

$(call built_of_normal_pkg,tslegacy-sysconfig): basic_fhs_installed

$(call built_of_normal_pkg,iproute2): gcc_installed
$(call built_of_normal_pkg,bc): readline_installed ncurses_installed
# $(call built_of_normal_pkg,amhello): gcc_installed
#
$(call built_of_normal_pkg,ncurses): gcc_installed \
 	pkg-config_installed

$(call built_of_normal_pkg,pkg-config): gcc_installed
$(call built_of_normal_pkg,readline): gcc_installed

$(PACKED_GCC_AND_LIBS): \
	mpc_installed mpfr_installed gmp_installed \
	binutils_installed zlib_installed

$(call built_of_normal_pkg,mpc): mpfr_installed
$(call built_of_normal_pkg,mpfr): gmp_installed
$(call built_of_normal_pkg,gmp): binutils_installed
$(call built_of_normal_pkg,binutils): zlib_installed
$(call built_of_normal_pkg,zlib): toolchain_adjusted

$(call built_of_normal_pkg,tzdata): glibc_installed

$(call built_of_normal_pkg,glibc): linux-headers_installed
$(call built_of_normal_pkg,linux-headers): basic_fhs_installed
$(call built_of_normal_pkg,basic_fhs): tool_links_created

toolchain_adjusted: glibc_installed