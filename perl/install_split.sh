#!/bin/bash

set -e

function install_license_readme
{
    install -dm755 $1/usr/share/doc/$2
    install -m644 ${BUILD_DIR}/${SRC_DIR}/{Artistic,README} $1/usr/share/doc/$2
}

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{perl-dev,perl-${perl_ABI},perl}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
BUILD_ZLIB=False BUILD_BZIP2=0 make DESTDIR=${INSTALL_DIR}/target install

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# perl-dev
install -dm755 ${PKG_DIRS[0]}/usr/
mv ${INSTALL_DIR}/target/usr/share ${PKG_DIRS[0]}/usr/
install_license_readme ${PKG_DIRS[0]} perl-dev

# perl-<ABI>
install -dm755 ${PKG_DIRS[1]}/usr/bin
mv ${INSTALL_DIR}/target/usr/bin/perl${perl_ABI} ${PKG_DIRS[1]}/usr/bin
mv ${INSTALL_DIR}/target/usr/lib ${PKG_DIRS[1]}/usr/

install_license_readme ${PKG_DIRS[1]} perl-${perl_ABI}

# perl
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[2]}/
install_license_readme ${PKG_DIRS[2]} perl
