#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{cifs-utils,cifs-utils-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install-strip

# cifs-utils
install -dm755 ${PKG_DIRS[0]}/usr
mv ${INSTALL_DIR}/target/sbin ${PKG_DIRS[0]}/
mv ${INSTALL_DIR}/target/usr/{,s}bin ${PKG_DIRS[0]}/usr/

# cifs-utils-dev
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[1]}/
