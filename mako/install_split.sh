#!/bin/bash

set -e

function install_readme_files
{
    for FILE in "${BUILD_DIR}/${SRC_DIR}"/{README*,readme*,COPYING*,Copyright*,LICENSE*,license*,NOTICE,NOTES,THANKS,AUTHORS}
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
PKG_DIR="${PACKAGING_LOCATION}/mako/${DESTDIR}"
rm -rf "$PKG_DIR"/*

# Install and adapt the package
#
# I adapted the configure and build procedures from the book
# `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
cd ${BUILD_DIR}/${SRC_DIR}
python setup.py install --optimize=1 --root="$PKG_DIR"

sed -i 's:mako-render:&3:g' setup.py
python3 setup.py install --optimize=1 --root="$PKG_DIR"

cd "$PKG_DIR"
bash "${INSTALL_DIR}/adapt.sh"

install_readme_files "$PKG_DIR" mako
