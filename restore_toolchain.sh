# No shebang here bcause, when this file is executed, /bin/bash does not exist
# yet. Therefore rely on Make's ability to find an appropriate bash.

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
