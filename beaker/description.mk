ifndef beaker_description_included
beaker_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

beaker_SRC_VERSION := 1.9.1
beaker_SRC_DIR := Beaker-$(beaker_SRC_VERSION)
beaker_SRC_ARCHIVE := $(beaker_SRC_DIR).tar.gz
beaker_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	python-dev_installed \
	python3-dev_installed \
	funcsigs_installed

beaker_TSL_TYPE := sw
beaker_TSL_RDEPS = \
	$(call bigger_equal_dep,funcsigs)
beaker_TSL_SRC_PKG := beaker

beaker_TSL_PKGS := beaker

endif
