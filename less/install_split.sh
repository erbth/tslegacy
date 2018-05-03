#!/bin/bash

set -e

function install_alt_license
{
    install -dm755 $1/usr/share/doc/$2
    cp ${BUILD_DIR}/${SRC_DIR}/{LICENSE,README} $1/usr/share/doc/$2
}

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{less,less-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install-strip

# less-dev
install -dm755 ${PKG_DIRS[1]}/usr/share
mv ${INSTALL_DIR}/target/usr/share/man ${PKG_DIRS[1]}/usr/share/

install_alt_license ${PKG_DIRS[1]} less-dev

# less
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[0]}/
install_alt_license ${PKG_DIRS[0]} less
