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

# The documentation symlink below might not work if it is not a 8.0 release
[ "${PKG_VERSION%.*}" == "8.0" ]

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

# Create symlink vi (adapted from LFS 8.2, p.219)
ln -sfv vim usr/bin/vi
for L in usr/share/man/{,*/}man1/vim.1
do
    ln -sfv vim.1 $(dirname $L)/vi.1
done

# Link the documentation (adapted from LFS 8.2, p.219)
if ! [ -d usr/share/doc ]
then
    install -dm755 usr/share/doc
fi

ln -sfTv ../vim/vim80/doc usr/share/doc/vim

# Create a basic vimrc
if ! [ -d etc ]
then
    install -dm755 etc
fi

cat > etc/vimrc << "EOF"
" This vimrc has ben inspired by and parts of it were copied from the suggested
" default vimrc in the book `Linux From Scratch', `Version 8.2', p.220 by
" Gerard Beekmans and Managing Editor Bruce Dubbs. At the time I initially wrote
" this file, the book was available from www.linuxfromscratch.org/lfs.

source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1

set nocompatible
set backspace=2
set mouse=a
syntax on

EOF
