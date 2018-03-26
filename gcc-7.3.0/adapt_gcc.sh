# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Adapted from LFS 8.2

set -e

# Historical location of the c preprocessor (required by the FHS)
ln -sv ../usr/bin/cpp lib

# Required according to LFS 8.2, p.118
ln -sv gcc usr/bin/cc

# Compatibility symlink for compiling programs with LTO
install -dm755 /usr/lib/bfs-plugins
ln -sfv ../../libexec/gcc/$(usr/bin/gcc -dumpmachine)/${PKG_VERSION_gcc}/liblto_plugin.so \
    /usr/lib/bfd-plugins
