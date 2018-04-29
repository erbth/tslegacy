#!/bin/bash

set -e
shopt -s extglob

# Clean the packaging install directories and form their names
declare -a PKG_DIRS
for PKG in ${gcc_TSL_PKGS}
do
    DIR=${PACKAGING_LOCATION}/${PKG}/${DESTDIR}
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

make DESTDIR=${INSTALL_DIR}/target install-strip

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# TODO: is this really lib64?

# libasan
install -dm755 ${PKG_DIRS[0]}/usr/lib64
mv ${INSTALL_DIR}/target/usr/lib64/libasan.so.* ${PKG_DIRS[0]}/usr/lib64/

# libatomic
install -dm755 ${PKG_DIRS[1]}/usr/lib64
mv ${INSTALL_DIR}/target/usr/lib64/libatomic.so.* ${PKG_DIRS[1]}/usr/lib64/

# libcc1
install -dm755 ${PKG_DIRS[2]}/usr/lib64
mv ${INSTALL_DIR}/target/usr/lib64/libcc1.so.* ${PKG_DIRS[2]}/usr/lib64/

# libcilkrts
install -dm755 ${PKG_DIRS[3]}/usr/lib64
mv ${INSTALL_DIR}/target/usr/lib64/libcilkrts.so.* ${PKG_DIRS[3]}/usr/lib64/

# libgcc
install -dm755 ${PKG_DIRS[4]}/usr/lib64
mv ${INSTALL_DIR}/target/usr/lib64/libgcc_s.so.* ${PKG_DIRS[4]}/usr/lib64/

install -dm755 ${PKG_DIRS[4]}/usr/share/doc/libgcc-${libgcc_ABI}
cp ${BUILD_DIR}/${SRC_DIR}/COPYING.RUNTIME ${PKG_DIRS[4]}/usr/share/doc/libgcc-${libgcc_ABI}/

# libgomp
install -dm755 ${PKG_DIRS[5]}/usr/lib64
mv ${INSTALL_DIR}/target/usr/lib64/libgomp.so.* ${PKG_DIRS[5]}/usr/lib64/

# libitm
install -dm755 ${PKG_DIRS[6]}/usr/lib64
mv ${INSTALL_DIR}/target/usr/lib64/libitm.so.* ${PKG_DIRS[6]}/usr/lib64/

# liblsan
install -dm755 ${PKG_DIRS[7]}/usr/lib64
mv ${INSTALL_DIR}/target/usr/lib64/liblsan.so.* ${PKG_DIRS[7]}/usr/lib64/

# libmpx
install -dm755 ${PKG_DIRS[8]}/usr/lib64
mv ${INSTALL_DIR}/target/usr/lib64/libmpx.so.* ${PKG_DIRS[8]}/usr/lib64/

# libmpxwrappers
install -dm755 ${PKG_DIRS[9]}/usr/lib64
mv ${INSTALL_DIR}/target/usr/lib64/libmpxwrappers.so.* ${PKG_DIRS[9]}/usr/lib64/

# libquadmath
install -dm755 ${PKG_DIRS[10]}/usr/lib64
mv ${INSTALL_DIR}/target/usr/lib64/libquadmath.so.* ${PKG_DIRS[10]}/usr/lib64/

# libssp
install -dm755 ${PKG_DIRS[11]}/usr/lib64
mv ${INSTALL_DIR}/target/usr/lib64/libssp.so.* ${PKG_DIRS[11]}/usr/lib64/

# libstdc++ (Do not move the GDB module)
install -dm755 ${PKG_DIRS[12]}/usr/lib64
mv ${INSTALL_DIR}/target/usr/lib64/libstdc++.so.*([0-9.]) \
    ${PKG_DIRS[12]}/usr/lib64/

# libtsan
install -dm755 ${PKG_DIRS[13]}/usr/lib64
mv ${INSTALL_DIR}/target/usr/lib64/libtsan.so.* ${PKG_DIRS[13]}/usr/lib64/

# libubsan
install -dm755 ${PKG_DIRS[14]}/usr/lib64
mv ${INSTALL_DIR}/target/usr/lib64/libubsan.so.* ${PKG_DIRS[14]}/usr/lib64/

# gcc
mv ${INSTALL_DIR}/target/{lib,usr} ${PKG_DIRS[15]}/
install -dm755 ${PKG_DIRS[15]}/usr/share/doc/gcc
cp ${BUILD_DIR}/${SRC_DIR}/COPYING.RUNTIME ${PKG_DIRS[15]}/usr/share/doc/gcc/
