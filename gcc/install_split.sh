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

cd ${BUILD_DIR}/${SRC_DIR}/build
make DESTDIR=${INSTALL_DIR}/target install-strip

cd ${INSTALL_DIR}/target
bash ../adapt.sh


# libasan
install -dm755 ${PKG_DIRS[0]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libasan.so.* ${PKG_DIRS[0]}/usr/lib/

# libatomic
install -dm755 ${PKG_DIRS[1]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libatomic.so.* ${PKG_DIRS[1]}/usr/lib/

# libcc1
install -dm755 ${PKG_DIRS[2]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libcc1.so.* ${PKG_DIRS[2]}/usr/lib/

# libcilkrts
install -dm755 ${PKG_DIRS[3]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libcilkrts.so.* ${PKG_DIRS[3]}/usr/lib/

# libgcc
install -dm755 ${PKG_DIRS[4]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libgcc_s.so.* ${PKG_DIRS[4]}/usr/lib/

install -dm755 ${PKG_DIRS[4]}/usr/share/doc/libgcc-${libgcc_ABI}
cp ${BUILD_DIR}/${SRC_DIR}/COPYING.RUNTIME ${PKG_DIRS[4]}/usr/share/doc/libgcc-${libgcc_ABI}/

# libgomp
install -dm755 ${PKG_DIRS[5]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libgomp.so.* ${PKG_DIRS[5]}/usr/lib/

# libitm
install -dm755 ${PKG_DIRS[6]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libitm.so.* ${PKG_DIRS[6]}/usr/lib/

# liblsan
install -dm755 ${PKG_DIRS[7]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/liblsan.so.* ${PKG_DIRS[7]}/usr/lib/

# libmpx
install -dm755 ${PKG_DIRS[8]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libmpx.so.* ${PKG_DIRS[8]}/usr/lib/

# libmpxwrappers
install -dm755 ${PKG_DIRS[9]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libmpxwrappers.so.* ${PKG_DIRS[9]}/usr/lib/

# libquadmath
install -dm755 ${PKG_DIRS[10]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libquadmath.so.* ${PKG_DIRS[10]}/usr/lib/

# libssp
install -dm755 ${PKG_DIRS[11]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libssp.so.* ${PKG_DIRS[11]}/usr/lib/

# libstdc++ (Do not move the GDB module)
install -dm755 ${PKG_DIRS[12]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libstdc++.so.*([0-9.]) \
    ${PKG_DIRS[12]}/usr/lib/

# libtsan
install -dm755 ${PKG_DIRS[13]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libtsan.so.* ${PKG_DIRS[13]}/usr/lib/

# libubsan
install -dm755 ${PKG_DIRS[14]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libubsan.so.* ${PKG_DIRS[14]}/usr/lib/

# gcc
mv ${INSTALL_DIR}/target/{lib,usr} ${PKG_DIRS[15]}/
install -dm755 ${PKG_DIRS[15]}/usr/share/doc/gcc
cp ${BUILD_DIR}/${SRC_DIR}/COPYING.RUNTIME ${PKG_DIRS[15]}/usr/share/doc/gcc/
