# Tab size: 4
# The first thing that needs to be saved:
THIS_MAKEFILE := $(lastword $(MAKEFILE_LIST))

# Programs
SHELL := bash
TPM ?= tpm

# Configure Make
.SECONDEXPANSION:

# TPM's database does not allow concurrent installation
.NOTPARALLEL:

# Make sure that the defult rule is the first rule defined in this Makfile
.PHONY: default_rule
default_rule: master

# Makefile utilities
include makefile_utilities.mk

# The version of the packaging scripts
TSLPACK_VERSION := 1.0.4

# Basic automatically derived information
export PACKAGING_RESOURCE_DIR := $(call remove_trailing_slash,$(PWD)/$(dir $(THIS_MAKEFILE)))

# Configuration
UTILS := $(PACKAGING_RESOURCE_DIR)/utils
RM_OLD_PKG_VERSIONS := $(UTILS)/remove_old_package_versions.native

TPM_CONF = $(TPM_TARGET)/etc/tpm/config.xml
export TOOLS_DIR = $(TPM_TARGET)/tools

# Check the environment
ifndef PACKAGING_BASE
$(error PACKAGING_BASE not set)
endif

ifndef COLLECTING_REPO
$(error COLLECTING_REPO not set)
endif

ifndef TPM_TARGET
$(error TPM_TARGET not set)
endif

ifndef PKG_ARCH
$(error PKG_ARCH not set)
endif

ifndef SOURCE_LOCATION
$(error SOURCE_LOCATION not set)
endif

# Automatically derived and retrieved information
PACKAGING_LOCATION := $(PACKAGING_BASE)/packaging_location

STATE_DIR := $(PACKAGING_BASE)/state
export COLLECTING_DIR := $(COLLECTING_REPO)/$(PKG_ARCH)

export PKGDB := $(STATE_DIR)/pkgdb.xml

SOURCE_PACKAGES := \
	alsa-lib \
	alsa-utils \
	autoconf \
	automake \
	bash \
	basic_fhs \
	beaker \
	bc \
	binutils \
	bison \
	bzip2 \
	cifs-utils \
	cmake \
	coreutils \
	dejagnu \
	diffutils \
	e2fsprogs \
	elfutils \
	eudev \
	expat \
	expect \
	file \
	findlib \
	findutils \
	fontconfig \
	font-util \
	freetype \
	funcsigs \
	gawk \
	gcc \
	gdbm \
	gettext \
	glib \
	glibc \
	gmp \
	gperf \
	grep \
	grub \
	gzip \
	harfbuzz \
	iana-etc \
	icu \
	inetutils \
	intltool \
	iproute2 \
	isc-dhcp \
	kbd \
	kmod \
	less \
	libdrm \
	libepoxy \
	libevdev \
	libffi \
	libinput \
	libpng \
	libtool \
	libuv \
	libXau \
	libxcb \
	libXdmcp \
	libxml2 \
	licenses \
	linux \
	linux-headers \
	llvm \
	m4 \
	mako \
	make \
	markup-safe \
	mesa \
	meson \
	mpc \
	mpfr \
	mtdev \
	ncurses \
	ninja \
	ntfs-3g \
	ocaml \
	ocamlbuild \
	openssl \
	patch \
	pcre \
	perl \
	pixman \
	pkg-config \
	procps-ng \
	python \
	python3 \
	readline \
	sed \
	shadow \
	sysvinit \
	talloc \
	tar \
	tcl-core \
	texinfo \
	toolchain \
	tpm \
	tslegacy \
	tslegacy-bootscripts \
	tslegacy-compiletime \
	tslegacy-config \
	tslegacy-installer \
	tslegacy-sysconfig \
	tslegacy-utils \
	tzdata \
	util-linux \
	util-macros \
	vim \
	wayland \
	wayland-protocols \
	xbitmaps \
	xcb-proto \
	xcursor-themes \
	xf86-input-libinput \
	xf86-input-synaptics \
	xf86-input-vmmouse \
	xf86-input-wacom \
	xf86-video-amdgpu \
	xf86-video-ati \
	xf86-video-fbdev \
	xf86-video-nouveau \
	xf86-video-vmware \
	xkeyboard-config \
	xinit \
	xml-light \
	xml-parser \
	xorg-server \
	xorgproto \
	xz \
	zlib

# Add the source packages of automatically generated packages
include generators/xorg/xorg_libraries/xorg-libraries.mk
include generators/xorg/xcb_utils/xcb_utils.mk
include generators/xorg/xorg_applications/xorg_applications.mk
include generators/xorg/xorg_fonts/xorg_fonts.mk

include $(SOURCE_PACKAGES:%=%/description.mk)

ALL_TSL_PACKAGES := $(foreach SRC,$(SOURCE_PACKAGES),$($(SRC)_TSL_PKGS))

# Packages in the collecting repo
ALL_COLLECTED := $(ALL_TSL_PACKAGES:%=$(STATE_DIR)/%_collected)

# Rules
.PHONY: master
master: all_packages_collected

.PHONY: all_packages_collected
all_packages_collected: $(ALL_COLLECTED)

# Building the packages
# Update the package database if tpmdb is available
$(ALL_COLLECTED): override PKG = $(patsubst $(STATE_DIR)/%_collected,%,$@)
$(ALL_COLLECTED): override SRC = $($(PKG)_TSL_SRC_PKG)
$(ALL_COLLECTED): $(STATE_DIR)/$$(SRC)_built
	> $@

$(SOURCE_PACKAGES:%=$(STATE_DIR)/%_built): override SRC = $(patsubst %_built,%,$(notdir $@))
$(SOURCE_PACKAGES:%=$(STATE_DIR)/%_built): \
	$(SOURCE_LOCATION)/$$($$(SRC)_SRC_ARCHIVE) \
	$(STATE_DIR)/$$(SRC)_clean_to_build | $(COLLECTING_DIR) $(STATE_DIR)
	cd $(SRC) && \
	$(MAKE) built
	for PKG in $($(SRC)_TSL_PKGS); do \
		cp $(PACKAGING_LOCATION)/$${PKG}/*.tpm.tar $(COLLECTING_DIR)/; \
	done
	if type tpmdb > /dev/zero 2>&1; \
	then \
		tpmdb --db $(PKGDB) --create-from-directory $(COLLECTING_DIR); \
	fi
	> $@

$(SOURCE_PACKAGES:%=$(STATE_DIR)/%_clean_to_build): override SRC = $(patsubst %_clean_to_build,%,$(notdir $@))
$(SOURCE_PACKAGES:%=$(STATE_DIR)/%_clean_to_build): \
	$$(patsubst %,$(STATE_DIR)/%,$$($$(SRC)_SRC_CDEPS)) | $(STATE_DIR)
	cd $(SRC) && \
	$(MAKE) clean
	> $@


# Installing packages to the compiletime system
# Convenience Rule
.PHONY: $(ALL_TSL_PACKAGES:%=%_installed)
$(ALL_TSL_PACKAGES:%=%_installed): $(STATE_DIR)/$$@

$(ALL_TSL_PACKAGES:%=$(STATE_DIR)/%_installed): override PKG = $(patsubst %_installed,%,$(notdir $@))
$(ALL_TSL_PACKAGES:%=$(STATE_DIR)/%_installed): \
	$(STATE_DIR)/$$(PKG)_collected | $(TPM_CONF) /tmp $(STATE_DIR)
	# Reinstall is not needed because of microversioning
	$(TPM) --install $(PKG)
	$(TPM) --remove-unneeded
	> $@

# Special build procedures that cannot be included in the packages' Makefiles
# since they require an overall view on the system:
# HarfBuzz and FreeType
$(STATE_DIR)/freetype_clean_to_build: $(STATE_DIR)/harfbuzz-dev_installed
$(STATE_DIR)/harfbuzz_built: $(STATE_DIR)/freetype_without_harfbuzz

$(STATE_DIR)/freetype_without_harfbuzz: override SRC = freetype
$(STATE_DIR)/freetype_without_harfbuzz: \
	$(SOURCE_LOCATION)/$$($$(SRC)_SRC_ARCHIVE) \
	$$(patsubst %,$(STATE_DIR)/%,$$($$(SRC)_SRC_CDEPS)) \
	$(STATE_DIR)/harfbuzz_clean_to_build | $(COLLECTING_DIR) $(STATE_DIR)
	cd $(SRC) && \
	$(MAKE) clean && \
	$(MAKE) WITHOUT_HARFBUZZ=1 built
	for PKG in $($(SRC)_TSL_PKGS); do \
		cp $(PACKAGING_LOCATION)/$${PKG}/*.tpm.tar $(COLLECTING_DIR)/; \
	done
	if type tpmdb > /dev/zero 2>&1; \
	then \
		tpmdb --db $(PKGDB) --create-from-directory $(COLLECTING_DIR); \
	fi
	tpm --install freetype-dev
	tpm --remove-unneeded
	> $@

# Other rules
$(TPM_CONF): $(MAKEFILE_LIST)
	install -dm755 $(dir $@)
	install -m 644 <(echo -e \
	"<?xml version=\"1.0\"?>\n\
	<tpm file_version=\"1.0\">\n\
	    <repo type=\"dir\">$(COLLECTING_REPO)</repo>\n\
	    <arch>$(PKG_ARCH)</arch>\n\
	</tpm>" || kill $$$$) $@

# If the script is updated, manual interaction is required. The dummy packages
# should never cause anything to rebuild automatically. Actually they are not
# needed anymore since bootstrapping is complete.
$(STATE_DIR)/dummy_pkgs_created: | create_dummy_pkgs.sh
	bash $<
	> $@

# If the script is updated, manual interaction is required. The dummy package
# should never cause anything to rebuild automatically.
$(SOURCE_LOCATION)/dummy_src_pkg.tar.gz: | create_dummy_src_pkg.sh
	bash $<


# Creating directories
$(STATE_DIR):
	mkdir -p $@

$(COLLECTING_DIR):
	mkdir -p $@

/tmp:
	install -dm 1777 $@


# Utils
$(RM_OLD_PKG_VERSIONS): FORCE
	cd $(UTILS) && \
	$(MAKE)

source_package_of_%:
	@echo $($(*)_TSL_SRC_PKG)

tsl_packages_of_%:
	@echo $($(*)_TSL_PKGS)

cdeps_installed_of_%:
	@echo $(patsubst %_installed,%,$($(*)_SRC_CDEPS))

# Cleaning
.PHONY: clean
clean: clean_collecting_repo clean_packages clean_compiletime_system

# Cleaning and tidying up the collecting repo
.PHONY: remove_old_collected_packages
remove_old_collected_packages: $(RM_OLD_PKG_VERSIONS) | $(COLLECTING_DIR)
	@ echo
	@ echo This will remove all but the latest versions of each package from the
	@ echo $(PKG_ARCH)-branch of the collecting repo.
	@ echo
	@ echo Shall we proceed ? [y/N]
	@ read -n1 -s && test "$$REPLY" == "y"
	$(RM_OLD_PKG_VERSIONS) "$(COLLECTING_DIR)"

.PHONY: clean_collecting_repo
clean_collecting_repo: clean_collecting_repo_confirmation
	rm -vf $(COLLECTING_DIR)/*

.PHONY: clean_collecting_repo_confirmation
clean_collecting_repo_confirmation:
	@ echo
	@ echo The $(PKG_ARCH)-branch of the collecting repo will be cleaned completely.
	@ echo
	@ echo Shall we proceed ? [y/N]
	@ read -n1 -s && test "$$REPLY" == "y"

# Cleaning packages
.PHONY: clean_packages
clean_packages: $(SOURCE_PACKAGES:%=%_clean)

.PHONY: $(SOURCE_PACKAGES:%=%_clean)
$(SOURCE_PACKAGES:%=%_clean): override SRC = $(patsubst %_clean,%,$@)
$(SOURCE_PACKAGES:%=%_clean): clean_packages_confirmation
	cd $(SRC) && \
	$(MAKE) clean
	rm -vf $(STATE_DIR)/$(SRC)_built
	rm -vf $(patsubst %,$(STATE_DIR)/%_collected,$($(SRC)_TSL_PKGS))
	rm -vf $(STATE_DIR)/$(SRC)_clean_to_build

.PHONY: clean_packages_confirmation
clean_packages_confirmation:
	@ echo
	@ echo Packages will be cleaned
	@ echo
	@ echo Shall we proceed ? [y/N]
	@ read -n1 -s && test "$$REPLY" == "y"

# Cleaning the compiletime system
.PHONY: clean_compiletime_system
clean_compiletime_system: clean_compiletime_system_confirmation
	rm -rvf $(TPM_TARGET)/{bin,boot,etc,home,lib,lib64,media,mnt,opt,root,sbin,srv,tmp,usr,var}
	rm -vf $(STATE_DIR)/*_installed $(STATE_DIR)/dummy_pkgs_created

.PHONY: clean_compiletime_system_confirmation
clean_compiletime_system_confirmation:
	@ echo
	@ echo The entire compiletime system will be cleaned
	@ echo
	@ echo Shall we proceed ? [y/N]
	@ read -n1 -s && test "$$REPLY" == "y"


# Useful targets
.PHONY: now
now:
	@echo $$(date --utc +%Y.%j).$$(( $$(date --utc +%s) - \
	$$(date --utc -d 'today 00:00:00' +%s) ))


# Distributing the packaging files
.PHONY: dist
dist:
	rm -rf tslegacy_packaging-*.tar.xz
	rm -rf tslegacy_packaging-$(TSLPACK_VERSION)
	mkdir tslegacy_packaging-$(TSLPACK_VERSION)
	cp -a \
		Makefile \
		adjust_toolchain.sh \
		create_dummy_pkgs.sh \
		create_dummy_src_pkg.sh \
		create_tool_links.sh \
		restore_toolchain.sh \
		set_env.sample \
		makefile_utilities.mk \
		show_todos.sh \
		restore_status_from_collecting_repo.sh \
		common \
		skel \
		generators \
		$(SOURCE_PACKAGES) \
		tslegacy_packaging-$(TSLPACK_VERSION)
	install -dm755 tslegacy_packaging-$(TSLPACK_VERSION)/utils
	cp -a \
		utils/{Makefile,remove_old_package_versions.ml,.gitignore,compute_rdeps.sh,update_pkgdb.sh,xorg,bash_utils.sh} \
		utils/{unpack_pkg.sh,select_rdeps_from_db.sh} \
		tslegacy_packaging-$(TSLPACK_VERSION)/utils
	tar -cJf tslegacy_packaging-$(TSLPACK_VERSION).tar.xz tslegacy_packaging-$(TSLPACK_VERSION)
	rm -rf tslegacy_packaging-$(TSLPACK_VERSION)

.PHONY: FORCE
FORCE:
