#!/bin/bash

set -e

function install_license
{
    install -dm755 $1/usr/share/doc/$2
    cp ${BUILD_DIR}/${SRC_DIR}/LICENSE $1/usr/share/doc/$2
}

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{openssl-${openssl_ABI},openssl,openssl-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

# The install procedure was adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.
cd ${BUILD_DIR}/${SRC_DIR}
sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
make DESTDIR=${INSTALL_DIR}/target MANSUFFIX=ssl install

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# openssl-<ABI>
install -dm755 ${PKG_DIRS[0]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/{engines-1.1,libcrypto.so.*,libssl.so.*} \
    ${PKG_DIRS[0]}/usr/lib/

install_license ${PKG_DIRS[0]} openssl-${openssl_ABI}

# openssl
install -dm755 ${PKG_DIRS[1]}/usr
mv ${INSTALL_DIR}/target/usr/bin ${PKG_DIRS[1]}/usr/
mv ${INSTALL_DIR}/target/etc ${PKG_DIRS[1]}/

install_license ${PKG_DIRS[1]} openssl

# openssl-dev
mv ${INSTALL_DIR}/target/usr/share/doc/openssl{,-dev}
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[2]}/
install_license ${PKG_DIRS[2]} openssl-dev
