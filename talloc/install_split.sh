#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for PKG in \
    libpytalloc-util-${libpytalloc_util_ABI} \
    libtalloc-${libtalloc_ABI} \
    talloc-python \
    talloc-dev
do
    DIR=${PACKAGING_LOCATION}/${PKG}/${DESTDIR}
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

# libpytalloc-util-<ABI>
install -dm755 ${PKG_DIRS[0]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libpytalloc-util.so.* ${PKG_DIRS[0]}/usr/lib/

# libtalloc-<ABI>
install -dm755 ${PKG_DIRS[1]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libtalloc.so.* ${PKG_DIRS[1]}/usr/lib/

# talloc-python
install -dm755 ${PKG_DIRS[2]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/python* ${PKG_DIRS[2]}/usr/lib/

# talloc-dev
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[3]}/
