# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Adapted from LFS 8.2

set -e

sed -i '/LIBTOOL_INSTALL/d' c++/Makefile.in
