# No shebang here as /bin/bash might not exist yet.

set -e

rm -rvf ${PACKAGING_LOCATION}/basic_fhs{,-dev}/${DESTDIR}/*

# Install to the 'normal' package
cd ${BUILD_DIR}/${SRC_DIR}
make ROOT=${PACKAGING_LOCATION}/basic_fhs/${DESTDIR} install

# Move documentation to the dev package
install -dvm755 ${PACKAGING_LOCATION}/basic_fhs-dev/${DESTDIR}/usr/share/doc

mv -v ${PACKAGING_LOCATION}/basic_fhs/${DESTDIR}/usr/share/doc/basic_fhs \
    ${PACKAGING_LOCATION}/basic_fhs-dev/${DESTDIR}/usr/share/doc/basic_fhs-dev
