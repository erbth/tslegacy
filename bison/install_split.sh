#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/bison-dev/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${PKG_DIRS[0]} install-strip

cd ${PKG_NAME[0]}
bash ${INSTALL_DIR}/adapt.sh

mv ${PKG_DIRS[0]}/usr/share/doc/bison{,-dev}
