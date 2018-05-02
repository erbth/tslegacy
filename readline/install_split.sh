#!/bin/bash

set -e

rm -rf ${PACKAGING_LOCATION}/readline{-dev,-${readline_SRC_ABI}}/${DESTDIR}/*

install -dm755 ${INSTALL_DIR}/target
cd ${BUILD_DIR}/${SRC_DIR}

# The install procedures was adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.
make DESTDIR=${INSTALL_DIR}/target SHLIB_LIBS="$(pkg-config ncursesw --libs)" install

# Adapt the installed files
. ${INSTALL_DIR}/adapt.sh

# Create the dev package
install -dm755 ${PACKAGING_LOCATION}/readline-dev/${DESTDIR}/usr/lib

mv ${INSTALL_DIR}/target/usr/share/doc/readline{,-dev}
mv ${INSTALL_DIR}/target/usr/{include,share} \
    ${PACKAGING_LOCATION}/readline-dev/${DESTDIR}/usr/

mv ${INSTALL_DIR}/target/usr/lib/lib{history,readline}.so \
    ${PACKAGING_LOCATION}/readline-dev/${DESTDIR}/usr/lib/

# Create the ABI versioned package
rmdir ${INSTALL_DIR}/target/usr/bin

mv ${INSTALL_DIR}/target/usr ${PACKAGING_LOCATION}/readline-${readline_SRC_ABI}/${DESTDIR}/
