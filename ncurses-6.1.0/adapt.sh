# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Adapted from LFS 8.2

set -e

SOURCE_DIR=${PWD}
cd ${WORKING_DIR}/${DESTDIR}

mv -v usr/lib/libncursesw.so.6* lib
ln -sfv ../../lib/$(readlink usr/lib/libncursesw.so) usr/lib/libncursesw.so

# Cool trick to allow linking with the ABI compatible non-widec libraries
# from LFS 8.2
umask 0022
for lib in ncurses form panel menu
do
    rm -vf usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > usr/lib/lib${lib}.so
    ln -sfv ${lib}w.pc usr/lib/pkgconfig/${lib}.pc
done

rm -vf usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > usr/lib/libcursesw.so
ln -sfv libncurses.so usr/lib/libcurses.so

# Install the documentation
install -dm755 usr/share/doc/ncurses
cp -v -R ${SOURCE_DIR}/doc/* usr/share/doc/ncurses
