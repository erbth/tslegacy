#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for PKG in \
    libblkid-${libblkid_ABI} \
    libfdisk-${libfdisk_ABI} \
    libmount-${libmount_ABI} \
    libsmartcols-${libsmartcols_ABI} \
    libuuid-${libuuid_ABI} \
    util-linux-dev \
    util-linux
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


# libblkid
install -dm755 ${PKG_DIRS[0]}/lib
mv ${INSTALL_DIR}/target/lib/libblkid.so.* ${PKG_DIRS[0]}/lib/

# libfdisk
install -dm755 ${PKG_DIRS[1]}/lib
mv ${INSTALL_DIR}/target/lib/libfdisk.so.* ${PKG_DIRS[1]}/lib/

# libmount
install -dm755 ${PKG_DIRS[2]}/lib
mv ${INSTALL_DIR}/target/lib/libmount.so.* ${PKG_DIRS[2]}/lib/

# libsmartcols
install -dm755 ${PKG_DIRS[3]}/lib
mv ${INSTALL_DIR}/target/lib/libsmartcols.so.* ${PKG_DIRS[3]}/lib/

# libuuid
install -dm755 ${PKG_DIRS[4]}/lib
mv ${INSTALL_DIR}/target/lib/libuuid.so.* ${PKG_DIRS[4]}/lib/

install -dm755 ${PKG_DIRS[4]}/usr/share/doc/libuuid-${libuuid_ABI}
cp ${BUILD_DIR}/${SRC_DIR}/Documentation/licenses/COPYING.BSD-3 \
    ${PKG_DIRS[4]}/usr/share/doc/libuuid-${libuuid_ABI}/

# Ensure /lib is empty
rmdir ${INSTALL_DIR}/target/lib

# util-linux-dev
install -dm755 ${PKG_DIRS[5]}/usr/share
mv ${INSTALL_DIR}/target/usr/{include,lib} ${PKG_DIRS[5]}/usr/
mv ${INSTALL_DIR}/target/usr/share/{doc,man} ${PKG_DIRS[5]}/usr/share/
mv ${PKG_DIRS[5]}/usr/share/doc/util-linux{,-dev}

cp ${BUILD_DIR}/${SRC_DIR}/Documentation/licenses/COPYING.{BSD-3,ISC,UCB} \
    ${PKG_DIRS[5]}/usr/share/doc/util-linux-dev/

# util-linux
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[6]}/

install -dm755 ${PKG_DIRS[6]}/usr/share/doc/util-linux
cp ${BUILD_DIR}/${SRC_DIR}/Documentation/licenses/COPYING.{BSD-3,ISC,UCB} \
    ${PKG_DIRS[6]}/usr/share/doc/util-linux/
