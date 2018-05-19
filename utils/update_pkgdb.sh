#!/bin/bash

set -e

if [ -z "$PACKAGING_BASE" ]
then
    echo "PACKAGING_BASE not set"
    exit 1
fi

[ -n "$COLLECTING_REPO" ] || { echo "COLLECTING_REPO not set"; exit 1; }

if ! [ -d "$PACKAGING_BASE/state" ]
then
    mkdir "$PACKAGING_BASE/state"
fi

tpmdb \
    --db "$PACKAGING_BASE/state/pkgdb.xml" \
    --create-from-directory "$COLLECTING_REPO"