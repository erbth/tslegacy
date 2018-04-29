#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{gmp-${gmp_ABI},gmpxx-${gmpxx_ABI},gmp-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install-strip
make DESTDIR=${INSTALL_DIR}/target install-html

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# gmp
install -dm755 ${PKG_DIRS[0]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libgmp.so.* ${PKG_DIRS[0]}/usr/lib/

# gmpxx
install -dm755 ${PKG_DIRS[1]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libgmpxx.so.* ${PKG_DIRS[1]}/usr/lib/

# gmp-dev
mv ${INSTALL_DIR}/target/usr ${PKG_DIRS[2]}/
