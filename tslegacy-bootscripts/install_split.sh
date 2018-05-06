#!/bin/bash

set -e

function install_source_readme
{
    install -dm755 $1/usr/share/doc/$2
    install -m644 ${BUILD_DIR}/${SRC_DIR}/README $1/usr/share/doc/$2/
}

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{tslegacy-bootscripts,tslegacy-bootscripts-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install

# tslegacy-bootscripts-dev
install -dm755 ${PKG_DIRS[1]}/usr/share
mv ${INSTALL_DIR}/target/usr/share/man ${PKG_DIRS[1]}/usr/share/

install_source_readme ${PKG_DIRS[1]} tslegacy-bootscripts-dev

# tslegacy-bootscripts
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[0]}/
install_source_readme ${PKG_DIRS[0]} tslegacy-bootscripts
