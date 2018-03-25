#!/bin/bash

# Adapted from LFS 8.2

set -e

if [ -e bin/ld-new ]
then
    mv -v bin/{ld,ld-old}
    mv -v $(uname -m)-pc-linux-gnu/bin/{ld,ld-old}
    mv -v bin/{ld-new,ld}
    ln -sv ../../bin/ld $(uname -m)-pc-linux-gnu/bin/ld
fi

gcc -dumpspecs | sed -e 's@/tools@@g' \
    -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
    -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' > \
    `dirname $(gcc --print-libgcc-file-name)`/specs

echo "Testing the adjusted toolchain:"

cd /tmp

echo 'int main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log

echo "    Testing if the correct dynamic linker is used"
case $(uname -m)
in
    x86_64)
        [ "$(readelf -l a.out | grep ': /lib')" == \
        "[Requested program interpreter: /lib64/ld-linux-x86-64.so.2" ]
        ;;

    i586)
    i686)
        [ "$(readelf -l a.out | grep ': /lib')" == \
        "[Requested program interpreter: /lib/ld-linux.so.2" ]
        ;;

    *)
        false
        ;;
esac

echo "    Testing if the right CRT is used"
read -r -d '' CRT_REFERENCE << 'EOF'
/usr/lib/../lib/crt1.o succeeded
/usr/lib/../lib/crti.o succeeded
/usr/lib/../lib/crtn.o succeeded
EOF

[ "$(grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log)" == "${CRT_REFERENCE}" ]

echo "    Testing the include directories"
read -r -d '' INCLUDE_REFERENCE << 'EOF'
#include <...> search starts here:
 /usr/include
EOF

[ "$(grep -B1 '^ /usr/include' dummy.log)" == "${INCLUDE_REFERENCE}" ]

echo "    Testing the linker's search path"
read -r -d '' LIB_REFERENCE << 'EOF'
SEARCH_DIR("/usr/lib")
SEARCH_DIR("/lib")
EOF

[ "$(grep 'SEARCH.*/usr/lib' dummy.log | sed 's|; |\n|g' | grep -v '-linux-gnu')" == \
"${LIB_REFERENCE}" ]

echo "    Testing if the correct libc was used"
[ "$(grep '/lib.*/libc.so.6 ' dummy.log)" == "attempt to open /lib/libc.so.6 succeeded" ]

echo "    Testing if GCC used the correct dynamic linked"
case $(uname -m)
in
    x86_64)
        [ "$(grep found dummy.log)" == \
        "found ld-linux-x86-64.so.2 at /lib/ld-linux-x86-64.so.2" ]
        ;;

    i586)
    i686)
        [ "$(grep found dummy.log)" == \
        "found ld-linux.so.2 at /lib/ld-linux.so.2" ]
        ;;

    *)
        false
        ;;
esac

rm -v dummy.c a.out dummy.log
