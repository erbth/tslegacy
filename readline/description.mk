# Information about the source package itself
readline_SRC_VERSION := 7.0
readline_SRC_ARCHIVE := readline-$(readline_SRC_VERSION).tar.gz
readline_SRC_DIR := readline-$(readline_SRC_VERSION)
readline_SRC_CDEPS := tool_links_created
export readline_SRC_ABI := 7

# Information about the differrent packages that are built out of this source
# package.
readline-$(readline_SRC_ABI)_TSL_TYPE := sw
readline-$(readline_SRC_ABI)_TSL_RDEPS :=
readline-$(readline_SRC_ABI)_TSL_SRC_PKG := readline

readline-dev_TSL_TYPE := sw
readline-dev_TSL_RDEPS = readline-$(readline_SRC_ABI)=$(call read_version,readline-$(readline_SRC_ABI))
readline-dev_TSL_SRC_PKG := readline

# A list of all the packages that are built out of this source package
readline_TSL_PKGS := readline-$(readline_SRC_ABI) readline-dev
