#!/bin/bash

set -e
set -x

SOURCE_DIR=${BUILD_DIR}/${SRC_DIR}

declare -a PKGS
for PKG in glibc-dev \
	glibc \
	glibc-${glibc_SRC_VERSION} \
	ld-linux-2 \
	ld-lsb-3 \
	libanl-1 \
	libBrokenLocale-1 \
	libcidn-1 \
	libcrypt-1 \
	libc-6 \
	libdl-2 \
	libmemusage-o \
	libm-6 \
	libmvec-1 \
	libnsl-1 \
	libnss_compat-2 \
	libnss_db-2 \
	libnss_dns-2 \
	libnss_files-2 \
	libnss_hesiod-2 \
	libpcprofile-o \
	libpthread-0 \
	libresolv-2 \
	librt-1 \
	libSegFault-o \
	libthread_db-1 \
	libutil-1 \
	sotruss-lib-o \
	locales-dev
do
	PKGS+=($PKG)
done

# Clean the install location and the packaging destdirs
for PKG in ${PKGS[@]}
do
    rm -rf ${PACKAGING_LOCATION}/${PKG}/${DESTDIR}/*
done

rm -rf ${INSTALL_DIR}/target
install -dm755 ${INSTALL_DIR}/target

cd ${SOURCE_DIR}/build
install -dm755 etc
touch etc/ld.so.conf
sed '/test-installation/s@$$(PERL)@echo not running@' -i ../Makefile
make DESTDIR=${INSTALL_DIR}/target install

cd ${INSTALL_DIR}/target

# Adapt the installed files
bash ${INSTALL_DIR}/adapt.sh


# Move files to the different packages
case ${PKG_ARCH} in
	amd64)
		install -dvm755 ${PACKAGING_LOCATION}/ld-linux-2/${DESTDIR}/lib{,64}

		mv -v lib/ld* ${PACKAGING_LOCATION}/ld-linux-2/${DESTDIR}/lib/
		mv -v lib64/ld-linux* ${PACKAGING_LOCATION}/ld-linux-2/${DESTDIR}/lib64/
		;;

	i386)
		install -dvm755 ${PACKAGING_LOCATION}/ld-linux-2/${DESTDIR}/lib

		for FILE in lib/ld*
		do
			if [ "${FILE%.so.*}" != "ld-lsb" ]
			then
				mv -v ${FILE} ${PACKAGING_LOCATION}/ld-linux-2/${DESTDIR}/lib/
			fi
		done
		;;

	*)
		echo Unsupported architecture ${PKG_ARCH}
		exit 1
		;;
esac

install -dvm755 ${PACKAGING_LOCATION}/ld-linux-2/${DESTDIR}/usr/share/doc/ld-linux-2
cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/ld-linux-2/${DESTDIR}/usr/share/doc/ld-linux-2/


case ${PKG_ARCH} in
	amd64)
		install -dvm755 ${PACKAGING_LOCATION}/ld-lsb-3/${DESTDIR}/lib64

		mv -v lib64/ld-lsb* ${PACKAGING_LOCATION}/ld-lsb-3/${DESTDIR}/lib64/
		;;

	i386)
		install -dvm755 ${PACKAGING_LOCATION}/ld-lsb-3/${DESTDIR}/lib

		mv -v lib/ld-lsb* ${PACKAGING_LOCATION}/ld-lsb-3/${DESTDIR}/lib/
		;;

	*)
		echo Unsupported architecture ${PKG_ARCH}
		exit 1
		;;
esac

install -dvm755 ${PACKAGING_LOCATION}/ld-lsb-3/${DESTDIR}/usr/share/doc/ld-lsb-3
cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/ld-lsb-3/${DESTDIR}/usr/share/doc/ld-lsb-3/


install -dvm755 ${PACKAGING_LOCATION}/libanl-1/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libanl-1/${DESTDIR}/usr/share/doc/libanl-1

mv -v lib/libanl* ${PACKAGING_LOCATION}/libanl-1/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libanl-1/${DESTDIR}/usr/share/doc/libanl-1/


install -dvm755 ${PACKAGING_LOCATION}/libBrokenLocale-1/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libBrokenLocale-1/${DESTDIR}/usr/share/doc/libBrokenLocale-1

mv -v lib/libBrokenLocale* ${PACKAGING_LOCATION}/libBrokenLocale-1/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libBrokenLocale-1/${DESTDIR}/usr/share/doc/libBrokenLocale-1/


install -dvm755 ${PACKAGING_LOCATION}/libcidn-1/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libcidn-1/${DESTDIR}/usr/share/doc/libcidn-1

mv -v lib/libcidn* ${PACKAGING_LOCATION}/libcidn-1/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libcidn-1/${DESTDIR}/usr/share/doc/libcidn-1/

install -dvm755 ${PACKAGING_LOCATION}/libcrypt-1/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libcrypt-1/${DESTDIR}/usr/share/doc/libcrypt-1

mv -v lib/libcrypt* ${PACKAGING_LOCATION}/libcrypt-1/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libcrypt-1/${DESTDIR}/usr/share/doc/libcrypt-1/


install -dvm755 ${PACKAGING_LOCATION}/libc-6/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libc-6/${DESTDIR}/usr/share/doc/libc-6

mv -v lib/libc* ${PACKAGING_LOCATION}/libc-6/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libc-6/${DESTDIR}/usr/share/doc/libc-6/


install -dvm755 ${PACKAGING_LOCATION}/libdl-2/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libdl-2/${DESTDIR}/usr/share/doc/libdl-2

mv -v lib/libdl* ${PACKAGING_LOCATION}/libdl-2/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libdl-2/${DESTDIR}/usr/share/doc/libdl-2/


install -dvm755 ${PACKAGING_LOCATION}/libmemusage-o/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libmemusage-o/${DESTDIR}/usr/share/doc/libmemusage-o

mv -v lib/libmemusage* ${PACKAGING_LOCATION}/libmemusage-o/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libmemusage-o/${DESTDIR}/usr/share/doc/libmemusage-o/


install -dvm755 ${PACKAGING_LOCATION}/libm-6/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libm-6/${DESTDIR}/usr/share/doc/libm-6

mv -v lib/libm{-*,.so*} ${PACKAGING_LOCATION}/libm-6/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libm-6/${DESTDIR}/usr/share/doc/libm-6/


install -dvm755 ${PACKAGING_LOCATION}/libmvec-1/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libmvec-1/${DESTDIR}/usr/share/doc/libmvec-1

mv -v lib/libmvec* ${PACKAGING_LOCATION}/libmvec-1/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libmvec-1/${DESTDIR}/usr/share/doc/libmvec-1/


install -dvm755 ${PACKAGING_LOCATION}/libnsl-1/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libnsl-1/${DESTDIR}/usr/share/doc/libnsl-1

mv -v lib/libnsl* ${PACKAGING_LOCATION}/libnsl-1/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libnsl-1/${DESTDIR}/usr/share/doc/libnsl-1/


install -dvm755 ${PACKAGING_LOCATION}/libnss_compat-2/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libnss_compat-2/${DESTDIR}/usr/share/doc/libnss_compat-2

mv -v lib/libnss_compat* ${PACKAGING_LOCATION}/libnss_compat-2/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libnss_compat-2/${DESTDIR}/usr/share/doc/libnss_compat-2/


install -dvm755 ${PACKAGING_LOCATION}/libnss_db-2/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libnss_db-2/${DESTDIR}/usr/share/doc/libnss_db-2

mv -v lib/libnss_db* ${PACKAGING_LOCATION}/libnss_db-2/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libnss_db-2/${DESTDIR}/usr/share/doc/libnss_db-2/


install -dvm755 ${PACKAGING_LOCATION}/libnss_dns-2/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libnss_dns-2/${DESTDIR}/usr/share/doc/libnss_dns-2

mv -v lib/libnss_dns* ${PACKAGING_LOCATION}/libnss_dns-2/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libnss_dns-2/${DESTDIR}/usr/share/doc/libnss_dns-2/


install -dvm755 ${PACKAGING_LOCATION}/libnss_files-2/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libnss_files-2/${DESTDIR}/usr/share/doc/libnss_files-2

mv -v lib/libnss_files* ${PACKAGING_LOCATION}/libnss_files-2/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libnss_files-2/${DESTDIR}/usr/share/doc/libnss_files-2/


install -dvm755 ${PACKAGING_LOCATION}/libnss_hesiod-2/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libnss_hesiod-2/${DESTDIR}/usr/share/doc/libnss_hesiod-2

mv -v lib/libnss_hesiod* ${PACKAGING_LOCATION}/libnss_hesiod-2/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libnss_hesiod-2/${DESTDIR}/usr/share/doc/libnss_hesiod-2/


install -dvm755 ${PACKAGING_LOCATION}/libpcprofile-o/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libpcprofile-o/${DESTDIR}/usr/share/doc/libpcprofile-o

mv -v lib/libpcprofile* ${PACKAGING_LOCATION}/libpcprofile-o/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libpcprofile-o/${DESTDIR}/usr/share/doc/libpcprofile-o/


install -dvm755 ${PACKAGING_LOCATION}/libpthread-0/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libpthread-0/${DESTDIR}/usr/share/doc/libpthread-0

mv -v lib/libpthread* ${PACKAGING_LOCATION}/libpthread-0/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libpthread-0/${DESTDIR}/usr/share/doc/libpthread-0/


install -dvm755 ${PACKAGING_LOCATION}/libresolv-2/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libresolv-2/${DESTDIR}/usr/share/doc/libresolv-2

mv -v lib/libresolv* ${PACKAGING_LOCATION}/libresolv-2/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libresolv-2/${DESTDIR}/usr/share/doc/libresolv-2/


install -dvm755 ${PACKAGING_LOCATION}/librt-1/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/librt-1/${DESTDIR}/usr/share/doc/librt-1

mv -v lib/librt* ${PACKAGING_LOCATION}/librt-1/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/librt-1/${DESTDIR}/usr/share/doc/librt-1/


install -dvm755 ${PACKAGING_LOCATION}/libSegFault-o/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libSegFault-o/${DESTDIR}/usr/share/doc/libSegFault-o

mv -v lib/libSegFault* ${PACKAGING_LOCATION}/libSegFault-o/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libSegFault-o/${DESTDIR}/usr/share/doc/libSegFault-o/


install -dvm755 ${PACKAGING_LOCATION}/libthread_db-1/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libthread_db-1/${DESTDIR}/usr/share/doc/libthread_db-1

mv -v lib/libthread_db* ${PACKAGING_LOCATION}/libthread_db-1/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libthread_db-1/${DESTDIR}/usr/share/doc/libthread_db-1/


install -dvm755 ${PACKAGING_LOCATION}/libutil-1/${DESTDIR}/lib \
    ${PACKAGING_LOCATION}/libutil-1/${DESTDIR}/usr/share/doc/libutil-1

mv -v lib/libutil* ${PACKAGING_LOCATION}/libutil-1/${DESTDIR}/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/libutil-1/${DESTDIR}/usr/share/doc/libutil-1/


install -dvm755 ${PACKAGING_LOCATION}/sotruss-lib-o/${DESTDIR}/usr/lib \
    ${PACKAGING_LOCATION}/sotruss-lib-o/${DESTDIR}/usr/share/doc/sotruss-lib-o

mv -v usr/lib/audit ${PACKAGING_LOCATION}/sotruss-lib-o/${DESTDIR}/usr/lib/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/sotruss-lib-o/${DESTDIR}/usr/share/doc/sotruss-lib-o/


install -dvm755 ${PACKAGING_LOCATION}/locales-dev/${DESTDIR}/usr/share/i18n \
    ${PACKAGING_LOCATION}/locales-dev/${DESTDIR}/usr/share/doc/locales-dev

mv -v usr/share/i18n/locales \
	${PACKAGING_LOCATION}/locales-dev/${DESTDIR}/usr/share/i18n/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/locales-dev/${DESTDIR}/usr/share/doc/locales-dev/


# glibc
install -dvm755 ${PACKAGING_LOCATION}/glibc/${DESTDIR}/usr/{lib,share} \
    ${PACKAGING_LOCATION}/glibc/${DESTDIR}/usr/share/doc/glibc

mv -v etc sbin var ${PACKAGING_LOCATION}/glibc/${DESTDIR}/
mv -v usr/{bin,libexec,sbin} ${PACKAGING_LOCATION}/glibc/${DESTDIR}/usr/
mv -v usr/lib/gconv ${PACKAGING_LOCATION}/glibc/${DESTDIR}/usr/lib/
mv -v usr/share/{i18n,locale} ${PACKAGING_LOCATION}/glibc/${DESTDIR}/usr/share/

cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/locales-dev/${DESTDIR}/usr/share/doc/locales-dev/


# glibc-dev
mv -v usr ${PACKAGING_LOCATION}/glibc-dev/${DESTDIR}/

install -dvm755 ${PACKAGING_LOCATION}/glibc-dev/${DESTDIR}/usr/share/doc/glibc-dev
cp -v ${SOURCE_DIR}/{LICENSES,README} \
    ${PACKAGING_LOCATION}/glibc-dev/${DESTDIR}/usr/share/doc/glibc-dev/


# glibc-$(glibc_SRC_VERSION)
# Nothing to copy here, this is ABI-fake-package (could be seen as meta-package)

# Remove empty directories to signal and ensure that they are empty
rmdir lib lib64
