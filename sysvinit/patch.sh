# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Some techniques used in this file have been adapted from the book
# `Linux From Scratch', `Version 8.2' by Gerard Beekmans and Managing Editor
# Bruce Dubbs. At the time I initially wrote this file, the book was available
# from www.linuxfromscratch.org/lfs.

set -e

# Verify that the script is executed as root user (import for creating files
# since the owner does not have to be then)
[ $UID -eq 0 ]

# This patch removes the following programs since they are installed by
# util-linux and procps-ng:
#   mountpoint, pidof, sulogin, mesg, last, lastb, utmpdump, wall
#
# LFS 8.2 does also remove some programs from SysVinit and I believe it is a
# good idea because the versions from SysVinit are reasonable to be older.

# The patch works probably only with the exact version
[ "${PKG_VERSION}" == "2.88.0" ]

patch -p0 < ${PACKAGING_RESOURCE_DIR}/adapt_sysvinit.patch
