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
declare -a PKG_DIRS
for DIR in ${PACKAGING_LOCATION}/{harfbuzz,harfbuzz-dev,harfbuzz-libs}/${DESTDIR}
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

# harfbuzz-dev
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

if [ -d "${PKG_DIRS[1]}/usr/share/doc/harfbuzz" ]
then
    mv "${PKG_DIRS[1]}/usr/share/doc/harfbuzz"{,-dev}
fi

install_readme_files "${PKG_DIRS[1]}" harfbuzz-dev

# harfbuzz-lib
cd ${INSTALL_DIR}/target

for DIR in usr/share/locale usr/lib/python*
do
    if [ -d "$DIR" ]
    then
        PARENT="$(dirname $DIR)"

        if ! [ -d "${PKG_DIRS[2]}/$PARENT" ]
        then
            install -dm755 "${PKG_DIRS[2]}/$PARENT"
        fi

        mv "$DIR" "${PKG_DIRS[2]}/$PARENT/"
    fi
done

while IFS='' read -r FILE
do
    DIR="$(dirname $FILE)"

    if ! [ -d "${PKG_DIRS[2]}/$DIR" ]
    then
        install -dm755 "${PKG_DIRS[2]}/$DIR"
    fi

    mv "$FILE" "${PKG_DIRS[2]}/$DIR/"
done < <(find \( -iname \*.so -o -iregex .\*\\.so\\.[0-9.]\* \) -a \( -type f -o -type l \))

install_readme_files "${PKG_DIRS[2]}" harfbuzz-libs

# harfbuzz
mv ${INSTALL_DIR}/target/* ${PKG_DIRS[0]}/
install_readme_files "${PKG_DIRS[0]}" harfbuzz
