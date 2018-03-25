# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Adapted from LFS 8.2

set -e

cd ${WORKING_DIR}/${DESTDIR}

mv -v usr/lib/lib{readline,history}.so.* lib
ln -sfv ../../lib/$(readlink usr/lib/libreadline.so) usr/lib/libreadline.so
ln -sfv ../../lib/$(readlink usr/lib/libhistory.so) usr/lib/libhistory.so
