#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for PKG in \
    libasm-${libasm_ABI} \
    libdw-${libdw_ABI} \
    libelf-${libelf_ABI} \
    elfutils-dev \
    elfutils
do
    DIR=${PACKAGING_LOCATION}/${PKG}/${DESTDIR}
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install-strip

# libasm-<ABI>
install -dm755 ${PKG_DIRS[0]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libasm*.so* ${PKG_DIRS[0]}/usr/lib/

# libdw-<ABI>
install -dm755 ${PKG_DIRS[1]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libdw*.so* ${PKG_DIRS[1]}/usr/lib/

# libelf-<ABI>
install -dm755 ${PKG_DIRS[2]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libelf*.so* ${PKG_DIRS[2]}/usr/lib/

# elfutils-dev
install -dm755 ${PKG_DIRS[3]}/usr
mv ${INSTALL_DIR}/target/usr/{include,lib} ${PKG_DIRS[3]}/usr/

# elfutils
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[4]}/
