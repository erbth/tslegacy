#!/bin/bash

set -e

function install_license
{
    install -dm755 $1/usr/share/doc/$2
    install -m644 ${BUILD_DIR}/${SRC_DIR}/LICENSE $1/usr/share/doc/$2/
}

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{libffi-${libffi_ABI},libffi-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install-strip

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# libffi
install -dm755 ${PKG_DIRS[0]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libffi.so.* ${PKG_DIRS[0]}/usr/lib/
install_license ${PKG_DIRS[0]} libffi-${libffi_ABI}

# libffi-dev
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[1]}/
install_license ${PKG_DIRS[1]} libffi-dev
