#!/bin/bash

set -e

if [ -z "$PACKAGING_BASE" ]
then
    echo "PACKAGING_BASE not set"
    exit 1
fi

if [ -z "$PKG_ARCH" ]
then
    echo "PKG_ARCH not set"
    exit 1
fi

sed -e's/[]$^\.*+?[]/\\&/g' | \
    sed 's/^/^/' | \
    sed 's/$/$/' | \
    sed -e's/[]$^\.*+?[]/\\&/g' |
    xargs tpmdb \
        --db "$PACKAGING_BASE/state/pkgdb.xml" \
        --arch "$PKG_ARCH" \
        --print-only-names \
        --only-in-latest-version \
        --get-dependencies
