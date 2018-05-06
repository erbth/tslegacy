#!/bin/bash

set -e

function install_license
{
    install -dm755 $1/usr/share/doc/$2
    install -m644 ${BUILD_DIR}/${SRC_DIR}/COPYING $1/usr/share/doc/$2
}

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{expat,libexpat-${libexpat_ABI},expat-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install-strip

# expat
install -dm755 ${PKG_DIRS[0]}/usr
mv ${INSTALL_DIR}/target/usr/bin ${PKG_DIRS[0]}/usr/

install_license ${PKG_DIRS[0]} expat

# libexpat-<ABI>
install -dm755 ${PKG_DIRS[1]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libexpat.so.* ${PKG_DIRS[1]}/usr/lib/

install_license ${PKG_DIRS[1]} libexpat-${libexpat_ABI}

# expat-dev
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[2]}/
mv ${PKG_DIRS[2]}/usr/share/doc/expat{,-dev}

install_license ${PKG_DIRS[2]} expat-dev
