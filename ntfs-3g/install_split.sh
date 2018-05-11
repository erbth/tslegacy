#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{libntfs-3g-${libntfs_3g_ABI},ntfs-3g-dev,ntfs-3g}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}

# For some reason, the Makfile seems to not install the lib directory
install -dm755 ${INSTALL_DIR}/target/lib
make DESTDIR=${INSTALL_DIR}/target install-strip

# libntfs-3g-<ABI>
mv ${INSTALL_DIR}/target/lib ${PKG_DIRS[0]}/

# This directory is empty.
rmdir ${INSTALL_DIR}/target/usr/lib/ntfs-3g

# ntfs-3g-dev
install -dm755 ${PKG_DIRS[1]}/usr
mv ${INSTALL_DIR}/target/usr/{include,lib,share} ${PKG_DIRS[1]}/usr/
mv ${PKG_DIRS[1]}/usr/share/doc/ntfs-3g{,-dev}

# ntfs-3g
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[2]}/
