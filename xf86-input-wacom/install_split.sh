#!/bin/bash

set -e

function install_readme_files
{
    for FILE in "${BUILD_DIR}/${SRC_DIR}"/{CREDITS*,CODE_OWNERS*,README*,readme*,COPYING*,Copyright*,COPYRIGHT*,LICENSE*,license*,NOTICE,NOTES,THANKS,AUTHORS}
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
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{xf86-input-wacom,xf86-input-wacom-dev}/${DESTDIR}
do
    PKG_DIRS+=($DIR)
    rm -rf ${DIR}/*
done

# Install and adapt the package
rm -rf ${INSTALL_DIR}/target/*
install -dm755 ${INSTALL_DIR}/target

cd ${BUILD_DIR}/${SRC_DIR}
make DESTDIR=${INSTALL_DIR}/target install-strip

cd ${INSTALL_DIR}/target
bash ../adapt.sh

# xf86-input-wacom-dev
cd ${INSTALL_DIR}/target

while IFS='' read -r FILE
do
    DIR="$(dirname $FILE)"

    if ! [ -d "${PKG_DIRS[1]}/$DIR" ]
    then
        install -dm755 "${PKG_DIRS[1]}/$DIR"
    fi

    mv "$FILE" "${PKG_DIRS[1]}/$DIR/"
done < <(find \( -iname \*.a -o -iname \*.la -o -iname \*gdb.py \) -a \( -type f -o -type l \))

for DIR in {,usr/}include usr/share/{man,{gtk-,}doc,info,aclocal} usr/{share,lib}/{pkgconfig,cmake}
do
    if [ -d "$DIR" ]
    then
        PARENT="$(dirname $DIR)"

        if ! [ -d "${PKG_DIRS[1]}/$PARENT" ]
        then
            install -dm755 "${PKG_DIRS[1]}/$PARENT"
        fi

        mv "$DIR" "${PKG_DIRS[1]}/$PARENT/"
    fi
done

if [ -d "${PKG_DIRS[1]}/usr/share/doc/xf86-input-wacom" ]
then
    mv "${PKG_DIRS[1]}/usr/share/doc/xf86-input-wacom"{,-dev}
fi

install_readme_files "${PKG_DIRS[1]}" xf86-input-wacom-dev

# xf86-input-wacom
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[0]}/
install_readme_files "${PKG_DIRS[0]}" xf86-input-wacom
