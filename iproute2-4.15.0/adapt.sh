# No shebang here because I don't want to depend on bash being installed in a
# specific location.

set -e

cd "${WORKING_DIR}/${DESTDIR}"
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
