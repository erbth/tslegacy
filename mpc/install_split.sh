#!/bin/bash

set -e

# Clean the packaging target directories and form their paths
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{mpc-${mpc_ABI},mpc-dev}/${DESTDIR}
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

# mpc
install -dm755 ${PKG_DIRS[0]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libmpc.so.* ${PKG_DIRS[0]}/usr/lib/

# mpc-dev
mv ${INSTALL_DIR}/target/usr ${PKG_DIRS[1]}/
