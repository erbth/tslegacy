# No shebang here because I don't want to depend on bash being installed in a
# specific location.

# Tab size: 4

# Adapted from LFS 8.2

set -e

[ $UID -eq 0 ]

ZONEINFO=${WORKING_DIR}/${DESTDIR}/usr/share/zoneinfo
install -dm755 $ZONEINFO/{posix,right}

for tz in etcetera southamerica northamerica europe africa antarctica asia \
          australasia backward pacificnew systemv
do
    zic -L /dev/null     -d $ZONEINFO        -y "sh yearistype.sh" ${tz}
    zic -L /dev/null     -d $ZONEINFO/posix  -y "sh yearistype.sh" ${tz}
    zic -L leapseconds   -d $ZONEINFO/right  -y "sh yearistype.sh" ${tz}
done

cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
zic -d $ZONEINFO -p America/New_York

ln -s /usr/share/zoneinfo/Europe/Berlin ${WORKING_DIR}/${DESTDIR}/etc/localtime
