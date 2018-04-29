#!/bin/bash

declare -a PKG_DIRS

for DIR in ${PACKAGING_LOCATION}/{zlib-dev,zlib-${zlib_SRC_ABI_VERSION}}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
done

# Clean the destination package directories
for DIR in ${PKG_DIRS[@]}
do
    rm -rf ${DIR}/*
done

# Install and adapt the source package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

make DESTDIR=${INSTALL_DIR}/target/ install

cd ${INSTALL_DIR}/target
../adapt.sh

# ABI versioned
mv ${INSTALL_DIR}/target/lib ${PKG_DIRS[1]}/
install -dm755 ${PKG_DIRS[1]}/usr/share/doc/zlib-${zlib_ABI}
cp ${BUILD_DIR}/${SRC_DIR}/README ${PKG_DIRS[1]}/usr/share/doc/zlib-${zlib_ABI}/

# dev
mv ${INSTALL_DIR}/target/usr ${PKG_DIRS[0]}/
install -dm755 ${PKG_DIRS[0]}/usr/share/doc/zlib-dev
cp ${BUILD_DIR}/${SRC_DIR}/README ${PKG_DIRS[0]}/usr/share/doc/zlib-dev/
