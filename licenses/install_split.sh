#!/bin/bash

set -e

rm -rf ${PACKAGING_LOCATION}/licenses/${DESTDIR}/*

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${PACKAGING_LOCATION}/licenses/${DESTDIR}/ install
