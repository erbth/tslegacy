#!/bin/bash

set -e

# Clean the packaging installation dirs and form their path
declare -a PKG_DIRS
for DIR in ${PACAKGING_LOCATION}/{mpfr-${mpfr_ABI},mpfr-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

make DESTDIR=${INSTALL_DIR}/target install-strip
make DESTDIR=${INSTALL_DIR}/target install-html

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# mpfr
install -dm755 ${PKG_DIRS[0]}/usr/lib
mv ${INSTALL_DIR}/target/usr/lib/libmpfr.so.* ${PKG_DIRS[0]}/usr/lib/

# mpfr-dev
mv ${INSTALL_DIR}/target/usr ${PKG_DIRS[1]}/
