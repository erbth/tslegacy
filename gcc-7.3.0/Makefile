# Tab size: 4
SHELL := bash
TPM	?= tpm
TAR ?= tar

ifndef BUILD_LOCATION
$(error BUILD_LOCATION not set)
endif

ifndef SOURCE_LOCATION
$(error SOURCE_LOCATION not set)
endif

# Package information:
# The version must consist of exactly three parts
PKG_TYPE_gcc := sw
PKG_NAME_gcc := gcc
export PKG_VERSION_gcc := 7.3.0
PKG_RDEPS_gcc := mpc mpfr gmp zlib binutils glibc linux

PKG_TYPE_libstdc++ := sw
PKG_NAME_libstdc++ := libstdc++
PKG_VERSION_libstdc++ := $(PKG_VERSION_gcc)
PKG_RDEPS_libstdc++ := glibc linux

PKG_TYPE_libmpx := sw
PKG_NAME_libmpx := libmpx
PKG_VERSION_libmpx := $(PKG_VERSION_gcc)
PKG_RDEPS_libmpx := glibc linux

PKG_TYPE_libvtv := sw
PKG_NAME_libvtv := libvtv
PKG_VERSION_libvtv := $(PKG_VERSION_gcc)
PKG_RDEPS_libvtv := glibc linux

PKG_TYPE_libssp := sw
PKG_NAME_libssp := libssp
PKG_VERSION_libssp := $(PKG_VERSION_gcc)
PKG_RDEPS_libssp := glibc linux

PKG_TYPE_libquadmath := sw
PKG_NAME_libquadmath := libquadmath
PKG_VERSION_libquadmath := $(PKG_VERSION_gcc)
PKG_RDEPS_libquadmath := glibc linux

PKG_TYPE_libatomic := sw
PKG_NAME_libatomic := libatomic
PKG_VERSION_libatomic := $(PKG_VERSION_gcc)
PKG_RDEPS_libatomic := glibc linux

COMPONENTS := gcc libstdc++ libmpx libvtv libssp libquadmath libatomic

ifndef PKG_ARCH
$(error PKG_ARCH not set)
endif

SOURCE_ARCHIVE := $(PKG_NAME_gcc)-$(PKG_VERSION_gcc).tar.xz

# Automatically derived information - shall be adapted if required
# This may need to be adapted
SOURCE_DIR := $(SOURCE_ARCHIVE:%.tar.xz=%)
SOURCE_ARCHIVE := $(SOURCE_LOCATION)/$(SOURCE_ARCHIVE)
PKG_BUILD_LOCATION := $(BUILD_LOCATION)/$(PKG_NAME_gcc)-$(PKG_VERSION_gcc)
export WORKING_DIR := $(PKG_BUILD_LOCATION)/$(PKG_ARCH)

ARTIFACTS := $(join $(COMPONENTS:%=$(WORKING_DIR)/%/),$(foreach c,$(COMPONENTS),$(PKG_NAME_$c)-))
ARTIFACTS := $(join $(ARTIFACTS),$(foreach c,$(COMPONENTS),$(PKG_VERSION_$c)_$(PKG_ARCH).tpm.tar))

# config
POSTINSTSH := postinst.sh
PRERMSH := prerm.sh
PREUPDATESH := preupdate.sh
ADAPTSH := adapt.sh
PATCHSH := patch.sh
DESCXML := desc.xml
export DESTDIR = destdir

# Configruation of Make
.SECONDEXPANSION:

.PHONY: all
all: $(ARTIFACTS)

$(ARTIFACTS): \
	adapted_$$(patsubst %/,%,$$(dir $$(patsubst $(WORKING_DIR)/%,%,$$@))) \
	postinstsh_$$(patsubst %/,%,$$(dir $$(patsubst $(WORKING_DIR)/%,%,$$@))) \
	desc_final_$$(patsubst %/,%,$$(dir $$(patsubst $(WORKING_DIR)/%,%,$$@)))
	cd $(WORKING_DIR)/$(patsubst %/,%,$(dir $(@:$(WORKING_DIR)/%=%))) && \
	$(TPM) --pack

$(COMPONENTS:%=postinstsh_%): \
	$$(wildcard $(basename $(POSTINSTSH))_$$(patsubst postinstsh_%,%,$$@)$(suffix $(POSTINSTSH))) \
	| $(WORKING_DIR)/$$(patsubst postinstsh_%,%,$$@)/
	if [ -n "$<" ]; \
	then \
		cp -L "$<" $(WORKING_DIR)/$(@:postinstsh_%=%)/$(POSTINSTSH); \
	fi && \
	> $@

# prermsh: $(wildcard $(PRERMSH)) | $(WORKING_DIR)
#	if [ -n "$<" ]; then cp "$<" $(WORKING_DIR); fi && > $@
#
# preupdatesh: $(wildcard $(PREUPDATESH)) | $(WORKING_DIR)
#	if [ -n "$<" ]; then cp "$<" $(WORKING_DIR); fi && > $@

desc_final_%: desc_initial_% adapted_%
	cd $(WORKING_DIR)/$(@:desc_final_%=%) && \
	$(TPM) --set-name $(PKG_NAME_$(@:desc_final_%=%)) && \
	$(TPM) --set-version $(PKG_VERSION_$(@:desc_final_%=%)) && \
	$(TPM) --set-arch $(PKG_ARCH) && \
	( for RDEP in $(PKG_RDEPS_$(@:desc_final_%=%)); \
	do $(TPM) --add-rdependency $$RDEP || exit; done ) && \
	$(TPM) --add-files && \
	> $(PWD)/$@

desc_initial_%: Makefile | $(WORKING_DIR)/%/
	cd $(WORKING_DIR)/$(@:desc_initial_%=%) && \
	if [ -e $(DESCXML) ]; then rm $(DESCXML); fi && \
	if [ -e $(DESTDIR) ]; then rm -r $(DESTDIR); fi && \
	$(TPM) --create-desc $(PKG_TYPE_$(@:desc_initial_%=%)) && \
	> $(PWD)/$@

$(COMPONENTS:%=adapted_%): \
	$$(wildcard $(basename $(ADAPTSH))_$$(patsubst adapted_%,%,$$@)$(suffix $(ADAPTSH))) \
	installed_$$(patsubst adapted_%,%,$$@)
	eval ADAPTSH="$(basename $(ADAPTSH))_$(@:adapted_%=%)$(suffix $(ADAPTSH))" && \
	if [ "$<" == "$${ADAPTSH}" ]; then \
	cd $(WORKING_DIR)/$(@:adapted_%=%)/$(DESTDIR) && \
	$(PWD)/$${ADAPTSH}; fi && \
	> $(PWD)/$@

installed_gcc: built desc_initial_gcc
	cd $(WORKING_DIR)/$(SOURCE_DIR)/build && \
	$(MAKE) DESTDIR=$(WORKING_DIR)/gcc/$(DESTDIR) install-strip && \
	> $(PWD)/$@

installed_libstdc++: built desc_initial_libstdc++
	cd $(WORKING_DIR)/$(SOURCE_DIR)/build && \
	$(MAKE) DESTDIR=$(WORKING_DIR)/$(@:installed_%=%)/$(DESTDIR) \
	install-strip-target-libstdc++-v3 && \
	> $(PWD)/$@


installed_%: built desc_initial_%
	cd $(WORKING_DIR)/$(SOURCE_DIR)/build && \
	$(MAKE) DESTDIR=$(WORKING_DIR)/$(@:installed_%=%)/$(DESTDIR) \
	install-strip-target-$(@:installed_%=%) && \
	> $(PWD)/$@

built: configured
	cd $(WORKING_DIR)/$(SOURCE_DIR)/build && $(MAKE) && > $(PWD)/built

configured: patched
	cd $(WORKING_DIR)/$(SOURCE_DIR) && \
	mkdir -p build && \
	cd build && \
	eval SED=sed && \
	../configure \
		--prefix=/usr \
		--enable-languages=c,c++ \
		--disable-multilib \
		--disable-bootstrap \
		--enable-libssp \
		--with-system-zlib && \
	> $(PWD)/$@

patched: $(wildcard $(PATCHSH)) source_ready
	if [ "$<" == "$(PATCHSH)" ]; then \
	cd $(WORKING_DIR)/$(SOURCE_DIR) && $(PWD)/$(PATCHSH); fi && > $(PWD)/$@

source_ready: Makefile $(SOURCE_ARCHIVE) | $(WORKING_DIR)
	$(TAR) -xf $(SOURCE_ARCHIVE) -C $(WORKING_DIR) && > $(PWD)/$@

$(WORKING_DIR):
	mkdir -p $@

$(WORKING_DIR)/%/: $(WORKING_DIR)
	mkdir -p $@

.PHONY: clean
clean:
	rm -rvf $(PKG_BUILD_LOCATION) source_ready patched configured built desc_initial_* \
	installed_* adapted_* desc_final_* postinstsh_* prermsh_* preupdatesh_*
