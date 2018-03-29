# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Adapted from LFS 8.2

set -e

cd ${WORKING_DIR}/${DESTDIR}

if ! [ -d lib ]
then
    install -dm755 lib
fi

mv -v usr/lib/libprocps.so.* lib && \
ln -sfv ../../lib/$(readlink usr/lib/libprocps.so) usr/lib/libprocps.so || true
