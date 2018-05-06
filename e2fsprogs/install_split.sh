#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for PKG in \
    libcom_err-${libcom_err_ABI} \
    libe2p-${libe2p_ABI} \
    libext2fs-${libext2fs_ABI} \
    libss-${libss_ABI} \
    e2fsprogs \
    e2fsprogs-dev
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
make DESTDIR=${INSTALL_DIR}/target install-libs

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# libcom_err-<ABI>
install -dm755 ${PKG_DIRS[0]}/{lib,usr/share}
mv ${INSTALL_DIR}/target/lib/libcom_err.so.* ${PKG_DIRS[0]}/lib/
mv ${INSTALL_DIR}/target/usr/share/et ${PKG_DIRS[0]}/usr/share/

# libe2p-<ABI>
install -dm755 ${PKG_DIRS[1]}/lib
mv ${INSTALL_DIR}/target/lib/libe2p.so.* ${PKG_DIRS[1]}/lib/

# libext2fs-<ABI>
install -dm755 ${PKG_DIRS[2]}/lib
mv ${INSTALL_DIR}/target/lib/libext2fs.so.* ${PKG_DIRS[2]}/lib/

# libss-<ABI>
install -dm755 ${PKG_DIRS[3]}/{lib,usr/share}
mv ${INSTALL_DIR}/target/lib/libss.so.* ${PKG_DIRS[3]}/lib/
mv ${INSTALL_DIR}/target/usr/share/ss ${PKG_DIRS[3]}/usr/share/

# Ensure that /lib is empty
rmdir ${INSTALL_DIR}/target/lib

# e2fsprogs
mv ${INSTALL_DIR}/target/{bin,etc,sbin} ${PKG_DIRS[4]}/

install -dm755 ${PKG_DIRS[4]}/usr/{lib,share}
mv ${INSTALL_DIR}/target/usr/sbin ${PKG_DIRS[4]}/usr/
mv ${INSTALL_DIR}/target/usr/lib/e2initrd_helper ${PKG_DIRS[4]}/usr/lib/
mv ${INSTALL_DIR}/target/usr/share/locale ${PKG_DIRS[4]}/usr/share/

# e2fsprogs-dev
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[5]}/
