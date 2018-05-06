#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/tpm/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${PKG_DIRS[0]} PREFIX=/usr install

cd ${PKG_DIRS[0]}
bash ${INSTALL_DIR}/adapt.sh
