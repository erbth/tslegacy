# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Adapted from LFS 8.2

set -e

cd ${WORKING_DIR}/${DESTDIR}

if ! [ -d sbin ]
then
    install -dm755 sbin
fi

# Adapted form LFS 8.2, p. 161
for target in depmod insmod lsmod modinfo modprobe rmmod
do
    ln -sfv ../bin/kmod sbin/$target
done

ln -sfv kmod bin/lsmod
