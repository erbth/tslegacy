#!/bin/bash

set -e

PKG_DIR=${PACKAGING_LOCATION}/binutils/${DESTDIR}

rm -rf ${PKG_DIR}/*

# Install and adapt the package
cd ${BUILD_DIR}/${SRC_DIR}/build
make DESTDIR=${PKG_DIR} tooldir=/usr install-strip

cd ${PKG_DIR}
bash ${INSTALL_DIR}/adapt.sh
