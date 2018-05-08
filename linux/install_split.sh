#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{linux,linux-doc}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make INSTALL_MOD_PATH=${INSTALL_DIR}/target modules_install

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# linux-doc
mv ${INSTALL_DIR}/target/usr ${PKG_DIRS[1]}/
mv ${PKG_DIRS[1]}/usr/share/doc/linux{,-doc}

# linux
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[0]}/
