# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Adapted from LFS 8.2

set -e

[ $UID -eq 0 ]

SOURCE_DIR=${PWD}
cd ${WORKING_DIR}/${DESTDIR}

case $(uname -m) in
        i?86)
            # For LSB compliance
            ln -sfv ld-linux.so.2 lib/ld-lsb.so.3
            ;;

        x86_64)
            # Link the 64 bit dynamic linker in the appropriate location
            ln -sfv ../lib/ld-linux-x86-64.so.2 lib64
            #For LSB compliance
            ln -sfv ../lib/ld-linux-x86-64.so.2 lib64/ld-lsb-x86-64.so.3
            ;;

        *)
            false
            ;;
esac

# Config file and runtime directory for nscd
cp -v ${SOURCE_DIR}/../nscd/nscd.conf etc/nscd.conf
install -dm755 var/cache/nscd

# Install basic locales
install -dm755 usr/lib/locale
usr/bin/localedef --prefix=${PWD} -i en_US -f ISO-8859-1 en_US
usr/bin/localedef --prefix=${PWD} -i en_US -f UTF-8 en_US.UTF-8

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
