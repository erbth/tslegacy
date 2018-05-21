#!/bin/bash

set -e

if [ -z "$1" ]
then
    echo "Package name not specified (required to prevent self loops)"
    exit 1
fi

if [ -z "$PACKAGING_RESOURCE_DIR" ]
then
    echo "PACKAGING_RESOURCE_DIR not set"
    exit 1
fi

while IFS='' read -r DEP
do
    tpm --add-dependency "$DEP"
done < <("$PACKAGING_RESOURCE_DIR/utils/compute_rdeps.sh" 2>/dev/zero | \
    sed "/^$1>=/ d")
