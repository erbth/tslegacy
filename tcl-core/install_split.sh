#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/tcl-core-dev/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}/unix
make DESTDIR=${PKG_DIRS[0]} install
make DESTDIR=${PKG_DIRS[0]} install-private-headers

cd ${PKG_DIRS[0]}
bash ${INSTALL_DIR}/adapt.sh

install -dm755 ${PKG_DIRS[0]}/usr/share/doc/tcl-core-dev

install -m644 ${BUILD_DIR}/${SRC_DIR}/license.terms ${PKG_DIRS[0]}/usr/share/doc/tcl-core-dev/
