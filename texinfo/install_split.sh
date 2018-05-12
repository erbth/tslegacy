#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{texinfo,texinfo-dev}/${DESTDIR}
do
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

# texinfo
install -dm755 ${PKG_DIRS[0]}/usr/{lib/texinfo,share}
mv ${INSTALL_DIR}/target/usr/bin ${PKG_DIRS[0]}/usr/
mv ${INSTALL_DIR}/target/usr/lib/texinfo/*.so ${PKG_DIRS[0]}/usr/lib/texinfo/
mv ${INSTALL_DIR}/target/usr/share/{locale,texinfo} ${PKG_DIRS[0]}/usr/share/

# texinfo-dev
mv ${INSTALL_DIR}/target/usr ${PKG_DIRS[1]}/
