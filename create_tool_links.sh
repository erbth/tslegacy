# No shebang here bcause, when this file is executed, /bin/bash does not exist
# yet. Therefore rely on Make's ability to find an appropriate bash.

# Adapted from LFS 8.2

for FILE in ../tools/bin/{bash,cat,dd,echo,ln,pwd,rm,stty}
do
    if ! [ -e $FILE ] && ! [ -L $FILE ]
    then
        ln -sv $FILE bin
    fi
done

for FILE in ../../tools/bin/{install,perl}
do
    if ! [ -e $FILE ] && ! [ -L $FILE ]
    then
        ln -sv $FILE usr/bin
    fi
done

for FILE in ../../tools/lib/libgcc_s.so{,.1}
do
    if ! [ -e $FILE ] && ! [ -L $FILE ]
    then
        ln -sv $FILE usr/lib
    fi
done

for FILE in ../../tools/lib/libstdc++.{a,so{,.6}}
do
    if ! [ -e $FILE ] && ! [ -L $FILE ]
    then
        ln -sv $FILE usr/lib
    fi
done

if ! [ -e bin/sh ] && ! [ -L bin/sh ]
then
    ln -sv bash bin/sh
fi

if ! [ -e usr/lib/gcc ] && ! [ -L usr/lib/gcc ]
then
    ln -sv ../../tools/lib/gcc usr/lib
fi
