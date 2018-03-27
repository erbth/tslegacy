# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Adapted from LFS 8.2

set -e

[ $UID -eq 0 ]

cd ${WORKING_DIR}/${DESTDIR}

if ! [ -d bin ]
then
    install -dm755 bin
fi

mv -v usr/bin/passwd bin || true
