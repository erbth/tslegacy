#!/bin/bash

set -e

umask 0022

# Install basic locales
if [ ! -e ${TPM_TARGET}/usr/lib/locale/locale-archive ]
then
    install -dm755 ${TPM_TARGET}/usr/lib/locale
    /usr/bin/localedef --prefix=${TPM_TARGET} -i en_US -f ISO-8859-1 en_US
    /usr/bin/localedef --prefix=${TPM_TARGET} -i en_US -f UTF-8 en_US.UTF-8
fi

# Update the texinfo file index
if type update-info-dir &> /dev/zero
then
    echo -e -n "\n    Updating the texinfo index"
    update-info-dir ${TPM_TARGET}/usr/share/info/
fi
