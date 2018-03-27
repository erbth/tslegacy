# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Adapted from LFS 8.2

set -e

[ $UID -eq 0 ]

cd ${WORKING_DIR}/${DESTDIR}

# Handle info pages
rm usr/share/info/dir
