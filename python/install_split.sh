#!/bin/bash

set -e

function install_license
{
    install -dm755 $1/usr/share/doc/$2
    install -m644 ${BUILD_DIR}/${SRC_DIR}/LICENSE $1/usr/share/doc/$2
}

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{libpython-${libpython_ABI},python,python-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# libpython-<ABI>
install -dm755 ${PKG_DIRS[0]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libpython*.so.* ${PKG_DIRS[0]}/usr/lib/

install_license ${PKG_DIRS[0]} libpython-${libpython_ABI}

# python-dev
install -dm755 ${PKG_DIRS[2]}/usr/{lib,share}
mv ${INSTALL_DIR}/target/usr/lib/{libpython*,pkgconfig} ${PKG_DIRS[2]}/usr/lib/
mv ${INSTALL_DIR}/target/usr/include ${PKG_DIRS[2]}/usr/
mv ${INSTALL_DIR}/target/usr/share/man ${PKG_DIRS[2]}/usr/share/

install_license ${PKG_DIRS[2]} python-dev

# python
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[1]}/
install_license ${PKG_DIRS[1]} python
