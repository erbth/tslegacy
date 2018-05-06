#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for PKG in \
    libgdbm-${libgdbm_ABI} \
    libgdbm-compat-${libgdbm_compat_ABI} \
    gdbm \
    gdbm-dev
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

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# libgdbm-<ABI>
install -dm755 ${PKG_DIRS[0]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libgdbm.so.* ${PKG_DIRS[0]}/usr/lib/

# libgdbm-compat-<ABI>
install -dm755 ${PKG_DIRS[1]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libgdbm_compat.so.* ${PKG_DIRS[1]}/usr/lib/

# gdbm
install -dm755 ${PKG_DIRS[2]}/usr
mv ${INSTALL_DIR}/target/usr/bin ${PKG_DIRS[2]}/usr/

# gdbm-dev
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[3]}/
