# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Adapted from LFS 8.2

set -e

# This cryptical patch will probably work with exactly on version only.
# Verfiy here that it was created for the built version number.
[ "${PKG_VERSION}" == "1.7.1" ]

# "First, change an internal script to use sed instead of ed:" (LFS 8.2, p. 108)
cat > bc/fix-libmath_h << "EOF"
#!/bin/bash
sed -e '1 s/^/{"/' \
    -e 's/$/",/' \
    -e '2,$ s/^/"/' \
    -e '$ d' \
    -i libmath.h

sed -e '$ s/$/0}/' \
    -i libmath.h
EOF

# Adapt configure to work even if bc's compiletime dependencies are not met yet.
# (Taken from LFS 8.2, p.108)
sed -i -e '/flex/s/as_fn_error/: ;; # &/' configure
