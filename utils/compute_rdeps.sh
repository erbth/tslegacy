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

# ldd
find -exec ldd {} ';' 2> /dev/zero | grep -e '.*\.so.*' | sed 's/^[ \t]*//' | \
    sed -e 's/[ ]*=>.*$//' -e 's/[ ]*(.*$//'

} | sort | uniq | sed -e '/linux-vdso/ d' | tee >(cat >&2) | \
    sed 's/^/.*/' | \
    xargs tpmdb \
        --db "$PACKAGING_BASE/state/pkgdb.xml" \
        --find-files \
        --arch "$PKG_ARCH" \
        --print-only-names \
    | sort | sed 's/^/\$(call bigger_equal_dep,/' | sed 's/$/)/' | \
    sed '$!s/$/ \\/'

exit 0
