#!/bin/bash

set -e

# Clean the packaging target
PKG_DIR="${PACKAGING_LOCATION}/tslegacy-thinclient/${DESTDIR}"
rm -rf "$PKG_DIR"/*

# Install and adapt the package
cd ${BUILD_DIR}/${SRC_DIR}
make ROOT="$PKG_DIR" install
