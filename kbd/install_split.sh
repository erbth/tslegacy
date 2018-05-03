#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{kbd,kbd-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install-strip

# kbd-dev
install -dm755 ${PKG_DIRS[1]}/usr/share
mv ${INSTALL_DIR}/target/usr/share/man ${PKG_DIRS[1]}/usr/share/

# kbd
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[0]}/
