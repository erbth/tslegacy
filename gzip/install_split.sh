#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{gzip,gzip-dev}/${DESTDIR}
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

# gzip
install -dm755 ${PKG_DIRS[0]}/usr/
mv ${INSTALL_DIR}/target/usr/bin ${PKG_DIRS[0]}/usr/

# gzip-dev
mv ${INSTALL_DIR}/target/usr ${PKG_DIRS[1]}/
