ifndef funcsigs_description_included
funcsigs_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

funcsigs_SRC_VERSION := 1.0.2
funcsigs_SRC_DIR := funcsigs-$(funcsigs_SRC_VERSION)
funcsigs_SRC_ARCHIVE := $(funcsigs_SRC_DIR).tar.gz
funcsigs_SRC_CDEPS := \
	gcc_installed \
	glibc-dev_installed \
	python-dev_installed

funcsigs_TSL_TYPE := sw
funcsigs_TSL_RDEPS =
funcsigs_TSL_SRC_PKG := funcsigs

funcsigs_TSL_PKGS := funcsigs

endif
