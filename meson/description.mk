ifndef meson_description_included
meson_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

meson_SRC_VERSION := 0.46.1
meson_SRC_DIR := meson-$(meson_SRC_VERSION)
meson_SRC_ARCHIVE := $(meson_SRC_DIR).tar.gz
meson_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	python3-dev_installeds \
	ninja-installed

meson_TSL_TYPE := sw
meson_TSL_RDEPS = \
	$(call bigger_equal_dep,python3)
meson_TSL_SRC_PKG := meson

meson-dev_TSL_TYPE := sw
meson-dev_TSL_RDEPS = \
	$(call equal_dep,meson)
meson-dev_TSL_SRC_PKG := meson

meson_TSL_PKGS := meson-dev meson

endif
