#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{eudev-${eudev_ABI},eudev-dev,eudev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}

# The make install command was adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.
make DESTDIR=${INSTALL_DIR}/target install-strip

# eudev-<ABI>
install -dm755 ${PKG_DIRS[0]}/lib
mv ${INSTALL_DIR}/target/lib/libudev.so.* ${PKG_DIRS[0]}/lib/

# eudev-dev
mv ${INSTALL_DIR}/target/usr ${PKG_DIRS[1]}/

# eudev
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[2]}/
