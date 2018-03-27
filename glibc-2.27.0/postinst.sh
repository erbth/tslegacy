#!/bin/bash

set -e

# Install basic locales
if [ ! -e ${TPM_TARGET}/usr/lib/locale/locale-archive ]
then
    install -dm755 ${TPM_TARGET}/usr/lib/locale
    ${TPM_TARGET}/usr/bin/localedef --prefix=${TPM_TARGET} -i en_US -f ISO-8859-1 en_US
    ${TPM_TARGET}/usr/bin/localedef --prefix=${TPM_TARGET} -i en_US -f UTF-8 en_US.UTF-8
fi
