#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/gettext-dev/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package

# The installation procedure was adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.
install -dm755 ${PKG_DIRS[0]}/usr/bin
install -m755 ${BUILD_DIR}/${SRC_DIR}/gettext-tools/src/{msgfmt,msgmerge,xgettext} \
    ${PKG_DIRS[0]}/usr/bin/

cd ${PKG_DIRS[0]}
bash ${INSTALL_DIR}/adapt.sh
