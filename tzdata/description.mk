ifndef tzdata_description_included
tzdata_description_included := 1

# Information about the source apckage itself
tzdata_SRC_VERSION := 2018d
tzdata_SRC_DIR := tzdata2018d
tzdata_SRC_ARCHIVE := $(tzdata_SRC_DIR).tar.gz
tzdata_SRC_CDEPS := glibc-dev_installed

# Information about the TSLegacy package built out of the source apckage
tzdata_TSL_TYPE := sw
tzdata_TSL_RDEPS := basic_fhs
tzdata_TSL_SRC_PKG := tzdata

# A list of a all TSL packages that are created out of this source package
tzdata_TSL_PKG := tzdata

endif
