#!/bin/bash

set -e

rm -rf ${PACKAGING_LOCATION}/readline{-dev,-${readline_SRC_ABI}}/${DESTDIR}/*

install -dm755 ${INSTALL_DIR}/target
cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install

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
