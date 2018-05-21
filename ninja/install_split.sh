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
PKG_DIR="${PACKAGING_LOCATION}/ninja/${DESTDIR}"
rm -rf "$PKG_DIR"/*

# Install and adapt the package

# The installation procedure was adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.

cd ${BUILD_DIR}/${SRC_DIR}
install -vdm755 "${PKG_DIR}/usr/bin"
install -vm755 ninja "${PKG_DIR}/usr/bin"
install -vDm644 misc/bash-completion "${PKG_DIR}/usr/share/bash-completion/completions/ninja"
install -vDm644 misc/zsh-completion "${PKG_DIR}/usr/share/zsh/site-functions/_ninja"

cd "${PKG_DIR}"
bash "${INSTALL_DIR}/adapt.sh"

install_readme_files "$PKG_DIR" ninja
