#!/bin/bash

set -e
set -x

[ $UID -eq 0 ]

PKG_DIR="${PACKAGING_LOCATION}/tzdata/${DESTDIR}"

# Clean the destination of the package
rm -rf ${PKG_DIR}/*

# The timezone compilation and installation procedure was adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.
cd ${BUILD_DIR}/${SRC_DIR}
ZONEINFO=${PKG_DIR}/usr/share/zoneinfo
install -dm755 $ZONEINFO/{posix,right}

for tz in etcetera southamerica northamerica europe africa antarctica asia \
          australasia backward pacificnew systemv
do
    zic -L /dev/null     -d $ZONEINFO        -y "sh yearistype.sh" ${tz}
    zic -L /dev/null     -d $ZONEINFO/posix  -y "sh yearistype.sh" ${tz}
    zic -L leapseconds   -d $ZONEINFO/right  -y "sh yearistype.sh" ${tz}
done

cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO/
zic -d $ZONEINFO -p America/New_York

install -dm755 ${PKG_DIR}/etc
ln -s /usr/share/zoneinfo/Europe/Berlin ${PKG_DIR}/etc/localtime

# Copy the LCIENSE file
install -dm755 ${PKG_DIR}/usr/share/doc/tzdata
cp ${BUILD_DIR}/${SRC_DIR}/LICENSE ${PKG_DIR}/usr/share/doc/tzdata/
