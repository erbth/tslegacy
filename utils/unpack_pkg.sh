#!/bin/bash

set -e

DIR="$(basename $1)"
DIR="${DIR%-*}"

mkdir "$DIR"

tar -xf "$1" -C "$DIR"

cd "$DIR"
install -dm755 destdir
cd destdir
tar -xf ../destdir.tar.gz

echo "Done"
