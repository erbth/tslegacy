#!/bin/bash

set -e

PKG_DIR="${PACKAGING_LOCATION}/linux-headers-dev/${DESTDIR}"

# Clean the destination
rm -rf ${PKG_DIR}/*

# Install the headers
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

# The installation process of the header files was adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.
cd ${BUILD_DIR}/${SRC_DIR}
make INSTALL_HDR_PATH=${INSTALL_DIR}/target headers_install
find ${INSTALL_DIR}/target/include \( -name .install -o -name ..install.cmd \) -delete

# Copy file to the final destination
install -dm755 ${PKG_DIR}/usr
mv -v ${INSTALL_DIR}/target/include ${PKG_DIR}/usr/
