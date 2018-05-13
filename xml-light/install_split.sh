#!/bin/bash

set -e

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/xml-light/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
cd ${BUILD_DIR}/${SRC_DIR}
install -dm755 ${PKG_DIRS[0]}/usr/lib/ocaml/site-lib
make -j1 DESTDIR=${PKG_DIRS[0]} install_ocamlfind

cd ${PKG_DIRS[0]}
bash ${INSTALL_DIR}/adapt.sh
