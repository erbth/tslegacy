#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{procps-ng-${procpsng_ABI},procps-ng-dev,procps-ng}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install-strip

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# procps-ng-<ABI>
mv ${INSTALL_DIR}/target/lib ${PKG_DIRS[0]}/

# procps-ng-dev
install -dm755 ${PKG_DIRS[1]}/usr/share
mv ${INSTALL_DIR}/target/usr/{include,lib} ${PKG_DIRS[1]}/usr/
mv ${INSTALL_DIR}/target/usr/share/{doc,man} ${PKG_DIRS[1]}/usr/share/
mv ${PKG_DIRS[1]}/usr/share/doc/procps-ng{,-dev}

# procps-ng
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[2]}/
