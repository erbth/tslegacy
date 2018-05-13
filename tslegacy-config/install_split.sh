#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/tslegacy-config/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
cd ${BUILD_DIR}/${SRC_DIR}
make ROOT=${PKG_DIRS[0]} install
