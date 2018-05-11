#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{libasound-${libasound_ABI},alsa-lib,alsa-lib-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install-strip

# libasound-<ABI>
install -dm755 ${PKG_DIRS[0]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libasound.so.* ${PKG_DIRS[0]}/usr/lib/

# alsa-lib
install -dm755 ${PKG_DIRS[1]}/usr/share
mv ${INSTALL_DIR}/target/usr/bin ${PKG_DIRS[1]}/usr/
mv ${INSTALL_DIR}/target/usr/share/alsa ${PKG_DIRS[1]}/usr/share/

# alsa-lib-dev
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[2]}/
