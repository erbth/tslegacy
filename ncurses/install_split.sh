#!/bin/bash

set -e

function install_licensing_info
{
    install -dm755 $1/usr/share/doc/$2
    cp ${BUILD_DIR}/${SRC_DIR}/COPYING $1/usr/share/doc/$2
}

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{ncurses,ncurses-${ncurses_ABI},ncurses-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# ncurses
install -dm755 ${PKG_DIRS[0]}/usr/{lib,share}
mv ${INSTALL_DIR}/target/usr/bin ${PKG_DIRS[0]}/usr/
mv ${INSTALL_DIR}/target/usr/share/{tabset,terminfo} ${PKG_DIRS[0]}/usr/share/
mv ${INSTALL_DIR}/target/usr/lib/terminfo ${PKG_DIRS[0]}/usr/lib/

install_licensing_info ${PKG_DIRS[0]} ncurses

# ncurses-<ABI>
install -dm755 ${PKG_DIRS[1]}/usr/lib
mv ${INSTALL_DIR}/target/lib ${PKG_DIRS[1]}/
mv ${INSTALL_DIR}/target/usr/lib/{libformw.so.*,libmenuw.so.*,libpanelw.so.*} \
    ${PKG_DIRS[1]}/usr/lib/

install_licensing_info ${PKG_DIRS[1]} ncurses-${ncurses_ABI}

# ncurses-dev
mv ${INSTALL_DIR}/target/usr ${PKG_DIRS[2]}/
mv ${PKG_DIRS[2]}/usr/share/doc/ncurses{,-dev}

install_licensing_info ${PKG_DIRS[2]} ncurses-dev
