#!/bin/bash

set -e

PKG_DIR=${PACKAGING_LOCATION}/binutils/${DESTDIR}

rm -rf ${PKG_DIR}/*

# Install and adapt the package
make DESTDIR=${PKG_DIR} tooldir=/usr install-strip

cd ${PKG_DIR}
${INSTALL_DIR}/adapt.sh
