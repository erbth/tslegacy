ifndef mako_description_included
mako_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

mako_SRC_VERSION := 1.0.7
mako_SRC_DIR := Mako-$(mako_SRC_VERSION)
mako_SRC_ARCHIVE := $(mako_SRC_DIR).tar.gz
mako_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	python-dev_installed \
	python3-dev_installed \
	beaker_installed \
	markup-safe_installed

mako_TSL_TYPE := sw
mako_TSL_RDEPS = \
	$(call bigger_equal_dep,beaker) \
	$(call bigger_equal_dep,markup-safe)
mako_TSL_SRC_PKG := mako

mako_TSL_PKGS := mako

endif
