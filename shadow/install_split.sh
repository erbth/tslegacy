#!/bin/bash

set -e

function install_copying_file
{
    install -dm755 $1/usr/share/doc/$2
    cp ${BUILD_DIR}/${SRC_DIR}/COPYING $1/usr/share/doc/$2/
}

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{shadow,shadow-dev}/${DESTDIR}
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

# shadow-dev
install -dm755 ${PKG_DIRS[1]}/usr/share
mv ${INSTALL_DIR}/target/usr/share/man ${PKG_DIRS[1]}/usr/share/

install_copying_file ${PKG_DIRS[1]} shadow-dev

# shadow
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[0]}/
install_copying_file ${PKG_DIRS[0]} shadow
