#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{findlib-dev,findlib}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make prefix=${INSTALL_DIR}/target install

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# findlib-dev
install -dm755 ${PKG_DIRS[0]}/usr
mv ${INSTALL_DIR}/target/usr/share ${PKG_DIRS[0]}/usr/

# findlib
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[1]}/
