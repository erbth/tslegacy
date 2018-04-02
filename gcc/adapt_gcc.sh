# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Adapted from LFS 8.2

set -e

[ $UID -eq 0 ]

# Historical location of the c preprocessor (required by the FHS)
if ! [ -d lib ]
then
    install -dm755 lib
fi

ln -sfv ../usr/bin/cpp lib

# Required according to LFS 8.2, p.118
ln -sfv gcc usr/bin/cc

# Compatibility symlink for compiling programs with LTO
install -dm755 usr/lib/bfd-plugins
ln -sfv ../../libexec/gcc/$(usr/bin/gcc -dumpmachine)/${PKG_VERSION_gcc}/liblto_plugin.so \
    usr/lib/bfd-plugins

# Handle info pages
rm -vf usr/share/info/dir
