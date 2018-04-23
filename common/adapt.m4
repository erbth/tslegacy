changequote(`[',`]')

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
test $UID -eq 0 || { echo "Must be run as root"; exit 1; }

define([STRIP_SYMBOLS],
[# Strip unneeded symbols by hand since the upstream package's build system does
# not provide install-strip. The stripping procedure was taken from LFS 8.2.
if test -d usr/lib
then
    find usr/lib -type f -name \*.a -exec strip -v --strip-debug {} ';'
    find usr/lib -type f -name \*.so* -exec strip -v --strip-unneeded {} ';'

    find usr/lib -name \*.la -delete
fi

if test -d lib
then
    find lib -type f -name \*.so* -exec strip -v --strip-unneeded {} ';'
fi

for DIR in {bin,sbin} usr/{bin,sbin,libexec}
do
    if test -d $DIR
    then
        find $DIR -type f -exec strip -v --strip-all {} ';'
    fi
done])

define([HANDLE_TEXINFO],
[# Handle info pages
rm -vf usr/share/info/dir])
