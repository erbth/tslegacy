# Information about the source package itself
linux-headers_SRC_VERSION := 4.16.5
linux-headers_SRC_DIR := linux-$(linux-headers_SRC_VERSION)
linux-headers_SRC_ARCHIVE := $(linux-headers_SRC_DIR).tar
linux-headers_SRC_CDEPS := tool_links_created

# Information about the TSClient LEGACY packages that are created out of this
# source package
linux-headers-dev_TSL_TYPE := sw
linux-headers-dev_TSL_RDEPS := $(call bigger_equal_dep,basic_fhs)
linux-headers-dev_TSL_SRC_PKG := linux-headers

# A list of the TSClient LEGACY packages that are created out of this source
# package
linux-headers_TSL_PKGS := linux-headers-dev
