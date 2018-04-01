# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Some techniques used in this file have been adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.

set -e

# Verify that the script is executed as root user (import for creating files
# since the owner does not have to be then)
[ $UID -eq 0 ]

# LFS 8.2 suggests the following to allow compiling eudev without having to
# install util-linux first. This avoids the circular dependency between these
# to packages.
cat > config.cache << "EOF"
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include"
EOF