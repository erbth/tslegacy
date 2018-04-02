# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Various techniques used in this file have been adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.

set -e

# Verify that the script is executed as root user (import for creating files
# since the owner does not have to be then)
[ $UID -eq 0 ]

SOURCE_DIR=${WORKING_DIR}/${SOURCE_DIR}

# Change to the installation location
cd ${WORKING_DIR}/${DESTDIR}

# Move libraries to a non shared location in the sense of the FHS
# This procedure originates in LFS
# if ! [ -d lib ]
# then
#     install -dm755 lib
# fi
#
# mv -v usr/lib/libprocps.so.* lib && \
# ln -sfv ../../lib/$(readlink usr/lib/libprocps.so) usr/lib/libprocps.so || true

# Strip unneeded symbols by hand since the upstream package's build system does
# not provide install-strip. The stripping procedure was taken from LFS 8.2.
# if [ -d usr/lib ]
# then
#     find usr/lib -type f -name \*.a -exec strip -v --strip-debug {} ';'
#     find usr/lib -type f -name \*.so* -exec strip -v --strip-unneeded {} ';'
#
#     find usr/lib -name \*.la -delete
# fi
#
# if [ -d lib ]
# then
#     find lib -type f -name \*.so* -exec strip -v --strip-unneeded {} ';'
# fi
#
# for DIR in {bin,sbin} usr/{bin,sbin,libexec}
# do
#     if [ -d $DIR ]
#     then
#         find $DIR -type f -exec strip -v --strip-all {} ';'
#     fi
# done

# Handle info pages
# rm -vf usr/share/info/dir

# Install the kernel's boot image (adapted from LFS 8.2, p.256)
if ! [ -d boot ]
then
    install -dm755 boot
fi

install -m644 ${SOURCE_DIR}/arch/x86/boot/bzImage boot/vmlinuz-${PKG_VERSION}
install -m644 ${SOURCE_DIR}/System.map boot/System.map-${PKG_VERSION}
install -m644 ${SOURCE_DIR}/.config boot/config-${PKG_VERSION}

# Install the documentation (adapted from LFS 8.2, p.256)
DOCDIR=usr/share/doc/linux-${PKG_VERSION}

if ! [ -d ${DOCDIR} ]
then
    install -dm755 ${DOCDIR}
fi

cp -r ${SOURCE_DIR}/Documentation/* ${DOCDIR}
chown -R 0:0 ${DOCDIR}
chmod -R 0755 ${DOCDIR}

cat > ${DOCDIR}/README.tslegacy << "EOF"
The kernel's configuration is based on a configuration from the Debian package
linux-image-4.9.0-6-amd64. Starting from there, I have made some adaptions and
followed the suffestions given in the book `Linux From Scratch', `Version 8.2'
by Gerard Beekmans and Managing Editor Bruce Dubbs. At the time I initially
wrote this file, the book was available from www.linuxfromscratch.org/lfs.

Maintainer of the TSClient legacy package:
Thomas Erbesdobler <t.erbesdobler@gmx.de>

EOF
