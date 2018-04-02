# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# I adapted these modifications from LFS 8.2 since the entire package ecosystem
# follows LFS closely.

set -e

[ $UID -eq 0 ]

# "Disable the installation of the groups program and its man pages, as
# Coreutils provides a better version." (LFS 8.2, p. 134)
# Copied form there:
sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

# Also taken from LFS 8.2 (p.134)
sed -i  -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
        -e 's@/var/spool/mail@/var/mail@' etc/login.defs

# Also taken from LFS 8.2 (p.134)
sed -i 's/1000/999/' etc/useradd
