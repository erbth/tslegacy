# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Adapted from LFS 8.2

set -e

[ $UID -eq 0 ]

SOURCE_DIR=${PWD}
cd ${WORKING_DIR}/${DESTDIR}

# Perform stripping (the procedure was adapted from LFS 8.2)
if [ -d usr/lib ]
then
    find usr/lib -type f -name \*.a -exec strip -v --strip-debug {} ';'
    find usr/lib -type f -name \*.so* -exec strip -v --strip-unneeded {} ';'

    find usr/lib -name \*.la -delete
fi

if [ -d lib ]
then
    find lib -type f -name \*.so* -exec strip -v --strip-unneeded {} ';'
fi

for DIR in {bin,sbin} usr/{bin,sbin,libexec}
do
    if [ -d $DIR ]
    then
        find $DIR -type f -exec strip -v --strip-all {} ';'
    fi
done

case $(uname -m) in
        i?86)
            # For LSB compliance
            ln -sfv ld-linux.so.2 lib/ld-lsb.so.3
            ;;

        x86_64)
            install -dm755 lib64
            # Link the 64 bit dynamic linker in the appropriate location
            ln -sfv ../lib/ld-linux-x86-64.so.2 lib64
            #For LSB compliance
            ln -sfv ../lib/ld-linux-x86-64.so.2 lib64/ld-lsb-x86-64.so.3
            ;;

        *)
            false
            ;;
esac

# Handle info pages
rm usr/share/info/dir

# Config file and runtime directory for nscd
# /etc was crated earlier in the Makefile
cp -v ${SOURCE_DIR}/nscd/nscd.conf etc/nscd.conf
install -dm755 var/cache/nscd

# Configure Glibc
umask 0022
cat > etc/nsswitch.conf << "EOF"
passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

EOF

cat > etc/ld.so.conf << "EOF"
/usr/local/lib

include /etc/ld.so.conf.d/*.conf

EOF

install -dm755 etc/ld.so.conf.d
