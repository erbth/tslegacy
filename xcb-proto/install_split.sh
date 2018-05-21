#!/bin/bash

set -e

function install_readme_files
{
    for FILE in "${BUILD_DIR}/${SRC_DIR}"/{README,COPYING*,NOTICE,NOTES}
    do
        if [ -r "$FILE" ]
        then
            if ! [ -d "$1/usr/share/doc/$2" ]
            then
                install -dm755 "$1/usr/share/doc/$2"
            fi

            install -m644 "$FILE" "$1/usr/share/doc/$2/"
        fi
    done
}

# Clean the packaging target
PKG_DIR="${PACKAGING_LOCATION}/xcb-proto-dev/${DESTDIR}"
rm -rf "${PKG_DIR}"/*

# Install and adapt the package
cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR="$PKG_DIR" install-strip

cd "$PKG_DIR"
bash "$INSTALL_DIR/adapt.sh"

install_readme_files "$PKG_DIR" xcb-proto-dev
