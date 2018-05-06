#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{vim,vim-dev}/${DESTDIR}
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

# vim-dev
install -dm755 ${PKG_DIRS[1]}/usr/share
mv ${INSTALL_DIR}/target/usr/share/man ${PKG_DIRS[1]}/usr/share/

install -dm755 ${PKG_DIRS[1]}/usr/share/doc/vim-dev
cp usr/share/vim/vim80/doc/uganda.txt ${PKG_DIRS[1]}/usr/share/doc/vim-dev/

# vim
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[0]}/

install -dm755 ${PKG_DIRS[0]}/usr/share/doc/vim
ln -s ../../vim/vim80/doc/uganda.txt ${PKG_DIRS[0]}/usr/share/doc/vim/
