#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{liblzma-${liblzma_ABI},xz-dev,xz}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install-strip

# liblzma-<ABI>
install -dm755 ${PKG_DIRS[0]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/liblzma.so.* ${PKG_DIRS[0]}/usr/lib/

# xz-dev
install -dm755 ${PKG_DIRS[1]}/usr/share
mv ${INSTALL_DIR}/target/usr/{lib,include} ${PKG_DIRS[1]}/usr/
mv ${INSTALL_DIR}/target/usr/share/{man,doc} ${PKG_DIRS[1]}/usr/share/
mv ${PKG_DIRS[1]}/usr/share/doc/xz{,-dev}

# xz
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[2]}/
