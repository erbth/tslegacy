# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Adapted from LFS 8.2

set -e

SOURCE_DIR=${PWD}
cd ${WORKING_DIR}/${DESTDIR}

install -dm755 lib

mv -v usr/lib/libncursesw.so.* lib && \
ln -sfv ../../lib/$(readlink usr/lib/libncursesw.so) usr/lib/libncursesw.so || \
true

# Cool trick to allow linking with the ABI compatible non-widec libraries
# from LFS 8.2
umask 0022
for lib in ncurses form panel menu
do
    rm -vf usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > usr/lib/lib${lib}.so
    ln -sfv ${lib}w.pc usr/share/pkgconfig/${lib}.pc
done

rm -vf usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > usr/lib/libcursesw.so
ln -sfv libncurses.so usr/lib/libcurses.so

# Strip unneeded symbols by hand since ncurses's build system does not provide
# install-strip. The stripping procedure was taken form LFS 8.2.
if [ -d usr/lib ]
then
    find usr/lib -type f -name \*.a -exec strip -v --strip-debug {} ';'
    find usr/lib -type f -name \*.so* -exec strip -v --strip-unneeded {} ';'

    find usr/lib -name \*.la -delete
fi

if [ -d lib ]
then
    find lib -type f -name \*.so* -exec strip -v --strip-unneeded {} ';'
fi

for DIR in {bin,sbin} usr/{bin,sbin,libexec}
do
    if [ -d $DIR ]
    then
        find $DIR -type f -exec strip -v --strip-all {} ';'
    fi
done

# Install the documentation
install -dm755 usr/share/doc/ncurses
cp -v -R ${SOURCE_DIR}/doc/* usr/share/doc/ncurses
