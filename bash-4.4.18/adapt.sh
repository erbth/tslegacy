# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Adapted from LFS 8.2

set -e

cd ${WORKING_DIR}/${DESTDIR}

if ! [ -d bin ]
then
    install -dm755 bin
fi

mv -v usr/bin/bash bin || true

# Handle info pages
rm -vf usr/share/info/dir
