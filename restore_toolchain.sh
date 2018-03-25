#!/bin/bash

set -e

if [ -e bin/ld-old ]
then
        mv bin/{ld,ld-new}
        mv bin/{ld-old,ld}
fi

if [ -e "$(uname -m)-pc-linux-gnu/bin/ld-old" ]
then
    rm $(uname -m)-pc-linux-gnu/bin/ld
    mv $(uname -m)-pc-linux-gnu/bin/{ld-old,ld}
fi

rm -vf `dirname $(gcc --print-libgcc-file-name)`/specs
