#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{bash,bash-dev}/${DESTDIR}
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

# bash-dev
install -dm755 ${PKG_DIRS[1]}/usr/{lib,share/doc}
mv ${INSTALL_DIR}/target/usr/include ${PKG_DIRS[1]}/usr/
mv ${INSTALL_DIR}/target/usr/lib/pkgconfig ${PKG_DIRS[1]}/usr/lib/
mv ${INSTALL_DIR}/target/usr/share/{info,man} ${PKG_DIRS[1]}/usr/share/
mv ${INSTALL_DIR}/target/usr/share/doc/bash ${PKG_DIRS[1]}/usr/share/doc/bash-dev
rmdir ${INSTALL_DIR}/target/usr/share/doc

# bash
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[0]}/
