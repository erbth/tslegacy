#!/bin/bash

set -e

function install_copying_readme
{
    install -dm755 $1/usr/share/doc/$2
    install -m644 ${BUILD_DIR}/${SRC_DIR}/{COPYING,README} $1/usr/share/doc/$2
}

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{libmagic-${libmagic_ABI},file,file-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install-strip

# libmagic-<ABI>
install -dm755 ${PKG_DIRS[0]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libmagic.so.* ${PKG_DIRS[0]}/usr/lib/

install_copying_readme ${PKG_DIRS[0]} libmagic-${libmagic_ABI}

# file
install -dm755 ${PKG_DIRS[1]}/usr/share
mv ${INSTALL_DIR}/target/usr/bin ${PKG_DIRS[1]}/usr/
mv ${INSTALL_DIR}/target/usr/share/misc ${PKG_DIRS[1]}/usr/share/

install_copying_readme ${PKG_DIRS[1]} file

# file-dev
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[2]}/

install_copying_readme ${PKG_DIRS[2]} file-dev
