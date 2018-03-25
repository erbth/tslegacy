# No shebang here bcause, when this file is executed, /bin/bash does not exist
# yet. Therefore rely on Make's ability to find an appropriate bash.

# Taken from LFS 8.2

ln -sfv ../tools/bin/{bash,cat,dd,echo,ln,pwd,rm,stty} bin
ln -sfv ../../tools/bin/{install,perl} usr/bin
ln -sfv ../../tools/lib/libgcc_s.so{,.1} usr/lib
ln -sfv ../../tools/lib/libstdc++.{a,so{,.6}} usr/lib
ln -sfv bash bin/sh
ln -sfv ../../tools/lib/gcc usr/lib
