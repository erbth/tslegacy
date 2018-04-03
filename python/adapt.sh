# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Various techniques used in this file have been adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.

set -e

# Verify that the script is executed as root user (import for creating files
# since the owner does not have to be then)
[ $UID -eq 0 ]

# Change to the installation location
cd ${WORKING_DIR}/${DESTDIR}

# Move libraries to a non shared location in the sense of the FHS
# This procedure originates in LFS
# if ! [ -d lib ]
# then
#     install -dm755 lib
# fi
#
# mv -v usr/lib/libprocps.so.* lib && \
# ln -sfv ../../lib/$(readlink usr/lib/libprocps.so) usr/lib/libprocps.so || true

# Strip unneeded symbols by hand since the upstream package's build system does
# not provide install-strip. The stripping procedure was taken from LFS 8.2.
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

# Handle info pages
# rm -vf usr/share/info/dir

# The book `Beyond Linux From Scratch', `Version 8.2' by the BLFS Development
# Team suggests to add write access for root to python's libraries to be
# consistent across all libraries.
# At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/blfs.
chmod -v 755 usr/lib/libpython2.7.so.1.0

# The tool `2to3' is installed with python3
rm -f usr/bin/2to3
