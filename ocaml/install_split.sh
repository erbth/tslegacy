#!/bin/bash

set -e

function install_license
{
    install -dm755 $1/usr/share/doc/$2
    install -m644 ${BUILD_DIR}/${SRC_DIR}/LICENSE $1/usr/share/doc/$2/
}

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{ocaml,ocaml-runtime,ocaml-dev}/${DESTDIR}
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

# ocaml
install -dm755 ${PKG_DIRS[0]}/usr/bin
mv ${INSTALL_DIR}/target/usr/bin/ocaml ${PKG_DIRS[0]}/usr/bin/
install_license ${PKG_DIRS[0]} ocaml

# ocaml-runtime
install -dm755 ${PKG_DIRS[1]}/usr/{bin,lib/ocaml}
mv ${INSTALL_DIR}/target/usr/bin/ocamlrun ${PKG_DIRS[1]}/usr/bin/
mv ${INSTALL_DIR}/target/usr/lib/ocaml/{*.so,*.cmx} ${PKG_DIRS[1]}/usr/lib/ocaml/
install_license ${PKG_DIRS[1]} ocaml-runtime

# ocaml-dev
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[2]}/
install_license ${PKG_DIRS[2]} ocaml-dev
