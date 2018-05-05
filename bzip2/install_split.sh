#!/bin/bash

set -e

function install_license
{
    install -dm755 $1/usr/share/doc/$2
    cp ${BUILD_DIR}/${SRC_DIR}/LICENSE $1/usr/share/doc/$2/
}

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{bzip2,libbz2-${libbz2_ABI},bzip2-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make PREFIX=${INSTALL_DIR}/target/usr install

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# bzip2
install -dm755 ${PKG_DIRS[0]}/usr
mv ${INSTALL_DIR}/target/usr/bin ${PKG_DIRS[0]}/usr/

install_license ${PKG_DIRS[0]} bzip2

# libbz2-<ABI>
install -dm755 ${PKG_DIRS[1]}/usr/lib
cp ${BUILD_DIR}/${SRC_DIR}/libbz2.so.* ${PKG_DIRS[1]}/usr/lib/

install_license ${PKG_DIRS[1]} libbz2-${libbz2_ABI}

# bzip2-dev
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[2]}/
ln -s libbz2.so.${libbz2_ABI} ${PKG_DIRS[2]}/usr/lib/libbz2.so

install_license ${PKG_DIRS[2]} bzip2-dev
