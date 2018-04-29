ifndef readline_description_included
readline_description_included := 1

include ${PACKAGING_RESOURCE_DIR}/makefile_utilities.mk

# Information about the source package itself
readline_SRC_VERSION := 7.0
readline_SRC_ARCHIVE := readline-$(readline_SRC_VERSION).tar.gz
readline_SRC_DIR := readline-$(readline_SRC_VERSION)
readline_SRC_CDEPS := gcc_installed

export readline_SRC_ABI := 7
export readline_ABI := $(readline_SRC_ABI)

# Information about the differrent packages that are built out of this source
# package.
readline-$(readline_SRC_ABI)_TSL_TYPE := sw
readline-$(readline_SRC_ABI)_TSL_RDEPS = \
	$(call bigger_equal_dep,glibc-$(glibc_SRC_VERSION)) \
	$(call bigger_equal_dep,ncurses-$(ncurses_ABI))
readline-$(readline_SRC_ABI)_TSL_SRC_PKG := readline

readline-dev_TSL_TYPE := sw
readline-dev_TSL_RDEPS = \
	$(call equal_dep,readline-$(readline_ABI))
readline-dev_TSL_SRC_PKG := readline

# A list of all the packages that are built out of this source package
readline_TSL_PKGS := readline-$(readline_SRC_ABI) readline-dev

endif
