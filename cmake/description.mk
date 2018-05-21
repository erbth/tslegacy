ifndef cmake_description_included
cmake_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

cmake_SRC_VERSION := 3.11.2
cmake_SRC_DIR := cmake-$(cmake_SRC_VERSION)
cmake_SRC_ARCHIVE := $(cmake_SRC_DIR).tar.gz
cmake_SRC_CDEPS := \
	licenses_installed \
	gcc_installed \
	glibc-dev_installed \
	libuv-dev_installed \
	expat-dev_installed \
	xz-dev_installed \
	ncurses-dev_installed \
	openssl-dev_installed \
	zlib-dev_installed

cmake_TSL_TYPE := sw
cmake_TSL_RDEPS = \
	$(call bigger_equal_dep,licenses)
cmake_TSL_SRC_PKG := cmake

cmake_TSL_PKGS := cmake

endif
