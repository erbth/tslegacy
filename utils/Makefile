OBUILD := ocamlbuild

.PHONY: all
all: remove_old_package_versions.native

remove_old_package_versions.native: FORCE
	$(OBUILD) $@

.PHONY: FORCE
FORCE:
