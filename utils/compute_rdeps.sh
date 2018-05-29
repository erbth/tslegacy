#!/bin/bash

set -e

if [ -z "$PKG_ARCH" ]
then
    echo "PKG_ARCH not set"
    exit 1
fi

if [ -z "$PACKAGING_BASE" ]
then
    echo "PACKAGING_BASE not set"
    exit 1
fi

if ! [ -r "$PACKAGING_BASE/state/pkgdb.xml" ]
then
    echo "Cannot read from \"$PACKAGING_BASE/state/pkgdb.xml\""
    exit 1
fi

{
# Objdump
find -exec objdump -p {} ';' 2> /dev/zero | grep NEEDED | awk '{print $2}' &&

# Find the dynamic linkers
find -exec readelf -l {} ';' 2> /dev/zero | grep interpreter | cut -d ']' -f 1 | \
    awk '{print $4}'

# ldd
# find -exec ldd {} ';' 2> /dev/zero | grep -e '.*\.so.*' | sed 's/^[ \t]*//' | \
#     sed -e 's/[ ]*=>.*$//' -e 's/[ ]*(.*$//'

# It is important to escape characters that are treated specially by the regular
# expression compiler of OCaml's Str module.
} | sort | uniq | sed -e '/linux-vdso/ d' | tee >(cat >&2) | \
    sed -e's/[]$^\.*+?[]/\\&/g' | \
    sed 's/^/.*/' | \
    sed 's/$/$/' | \
    sed -e's/[]$^\.*+?[]/\\&/g' | \
    xargs tpmdb \
        --db "$PACKAGING_BASE/state/pkgdb.xml" \
        --find-files \
        --arch "$PKG_ARCH" \
        --only-in-latest-version \
    | sort | sed 's/=/>=/' | sed 's/@.*$//'

exit 0
