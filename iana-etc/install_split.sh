#!/bin/bash

set -e

SOURCE_DIR=${BUILD_DIR}/${SRC_DIR}

# Clean the packaging target
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/iana-etc/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install the package
cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${PKG_DIRS[0]} install

DOCDIR=${PKG_DIRS[0]}/usr/share/doc/iana-etc

install -dm755 ${DOCDIR}
install -m644 ${SOURCE_DIR}/{COPYING,CREDITS,NEWS,README,VERSION} ${DOCDIR}
