#!/bin/bash

set -e

function install_readme_files
{
    if ! [ -d "$1/usr/share/doc/$2" ]
    then
        install -dm755 "$1/usr/share/doc/$2"
    fi

    for FILE in "${BUILD_DIR}/${SRC_DIR}"/{README*,COPYING*,Copyright*,LICENSE*,NOTICE,NOTES,THANKS,AUTHORS}
    do
        if [ -r "$FILE" ]
        then
            install -m644 "$FILE" "$1/usr/share/doc/$2/"
        fi
    done

    install -m644 "${BUILD_DIR}/${SRC_DIR}/Licenses/README.rst" \
        "$1/usr/share/doc/$2/README.licenses.rst"
}

# Clean the packaging target
PKG_DIR="${PACKAGING_LOCATION}/cmake/${DESTDIR}"
rm -rf "$PKG_DIR"/*

# Install and adapt the package
cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR="$PKG_DIR" install

cd "$PKG_DIR"
bash "$INSTALL_DIR/adapt.sh"

install_readme_files "$PKG_DIR" cmake
