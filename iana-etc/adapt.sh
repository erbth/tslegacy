# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Adapted from LFS 8.2

set -e

[ $UID -eq 0 ]

SOURCE_DIR=${PWD}
cd ${WORKING_DIR}/${DESTDIR}

DOCDIR=${WORKING_DIR}/${DESTDIR}/usr/share/doc/iana-etc

if ! [ -d ${DOCDIR} ]
then
    install -dm755 ${DOCDIR}
fi

install -m755 ${SOURCE_DIR}/{COPYING,CREDITS,NEWS,README,VERSION} ${DOCDIR}

cat > ${DOCDIR}/README.tslegacy << "EOF"
The iana etc package is part of Linux From Scratch, a projects that describes
how a Linux system can be constructed from the sources of various software
packages. Its homepage is located at www.linuxfromscratch.org/lfs.

This version, which is distributed with TSClient legacy, is unmodified however
the package's COPYING, CREDITS, NEWS, README, and VERSION files are installed to
/usr/share/doc/iana-etc while these would not be distributed with the generated
config files in the upstream package. Additionally, this file (README.tslegacy)
was added.

Maintainer for the TSClient legacy package is Thomas Erbesdobler
<t.erbesdobler@gmx.de>

27th March, 2018
EOF

chmod 755 ${DOCDIR}/README.tslegacy
