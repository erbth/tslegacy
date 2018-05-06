#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{tar,tar-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}

# The installation procedure was adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.
make DESTDIR=${INSTALL_DIR}/target install-strip
make -C doc DESTDIR=${INSTALL_DIR}/target install-html

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# tar-dev
install -dm755 ${PKG_DIRS[1]}/usr/share
mv ${INSTALL_DIR}/target/usr/share/{doc,info,man} ${PKG_DIRS[1]}/usr/share/
mv ${PKG_DIRS[1]}/usr/share/doc/tar{,-dev}

# tar
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[0]}/
