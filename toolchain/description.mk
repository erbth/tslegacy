ifndef toolchain_description_included
toolchain_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

toolchain_SRC_VERSION := 0.0.0
toolchain_SRC_DIR := dummy_src_pkg
toolchain_SRC_ARCHIVE := dummy_src_pkg.tar.gz
toolchain_SRC_CDEPS := \
	bash-dev_collected \
	binutils_collected \
	bison-dev_collected \
	bzip2-dev_collected \
	coreutils-dev_collected \
	dejagnu-dev_collected \
	diffutils-dev_collected \
	expect-dev_collected \
	file-dev_collected \
	findlib-dev_collected \
	findutils-dev_collected \
	gawk-dev_collected \
	gcc_collected \
	gettext-dev_collected \
	grep-dev_collected \
	gzip-dev_collected \
	linux-headers-dev_collected \
	m4-dev_collected \
	make-dev_collected \
	ncurses-dev_collected \
	ocamlbuild-dev_collected \
	ocaml-dev_collected \
	patch-dev_collected \
	perl-dev_collected \
	sed-dev_collected \
	tar-dev_collected \
	tcl-core-dev_collected \
	texinfo-dev_collected \
	tpm_collected \
	util-linux-dev_collected \
	xml-light_collected \
	xz-dev_collected

toolchain_TSL_TYPE := sw
toolchain_TSL_RDEPS = \
	$(foreach PKG,$(toolchain_SRC_CDEPS:%_collected=%),\
		$(call bigger_equal_dep,$(PKG)))
toolchain_TSL_SRC_PKG := toolchain

toolchain_TSL_PKGS := toolchain

endif
