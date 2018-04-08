#!/bin/bash

set -e

umask 0022

# Install basic locales
rm -rvf /usr/lib/locale/locale-archive
install -dm755 /usr/lib/locale

/usr/bin/localedef -i en_US -f ISO-8859-1 en_US
/usr/bin/localedef -i en_US -f UTF-8 en_US.UTF-8

# Update the texinfo file index
if type update-info-dir &> /dev/zero
then
    echo -e -n "\n    Updating the texinfo index"
    update-info-dir
fi
