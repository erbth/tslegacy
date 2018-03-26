# No shebang here bcause, when this file is executed, /bin/bash does not exist
# yet. Therefore rely on Make's ability to find an appropriate bash.

# Adapted from LFS 8.2

for FILE in bin/{bash,cat,dd,echo,ln,pwd,rm,stty}
do
    if ! [ -e $FILE ] && ! [ -L $FILE ]
    then
        ln -sv ../tools/$FILE bin
    fi
done

for FILE in bin/{install,perl}
do
    if ! [ -e usr/$FILE ] && ! [ -L usr/$FILE ]
    then
        ln -sv ../../tools/$FILE usr/bin
    fi
done

for FILE in lib/libgcc_s.so{,.1}
do
    if ! [ -e usr/$FILE ] && ! [ -L usr/$FILE ]
    then
        ln -sv ../../tools/$FILE usr/bin
    fi
done

for FILE in lib/libstdc++.{a,so{,.6}}
do
    if ! [ -e usr/$FILE ] && ! [ -L usr/$FILE ]
    then
        ln -sv ../../tools/$FILE usr/lib
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
