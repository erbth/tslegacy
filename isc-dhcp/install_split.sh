#!/bin/bash

set -e

function install_license
{
    install -dm755 $1/usr/share/doc/$2
    install -m644 ${BUILD_DIR}/${SRC_DIR}/LICENSE $1/usr/share/doc/$2/
}

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{isc-dhcp-client,isc-dhcp-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}/client
make -j1 DESTDIR=${INSTALL_DIR}/target install-strip

install -v -dm755 "${INSTALL_DIR}/target"/sbin && \
install -v -m755 scripts/linux "${INSTALL_DIR}/target"/sbin/dhclient-script

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# isc-dhcp-dev
install -dm755 ${PKG_DIRS[1]}/usr
mv ${INSTALL_DIR}/target/usr/share ${PKG_DIRS[1]}/usr/
install_license ${PKG_DIRS[1]} isc-dhcp-dev

# isc-dhcp-client
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[0]}/
install_license ${PKG_DIRS[0]} isc-dhcp-client
