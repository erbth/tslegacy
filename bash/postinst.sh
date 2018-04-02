#!/bin/bash

set -e

# Update the texinfo file index
umask 0022
if type update-info-dir &> /dev/zero
then
    echo -e -n "\n    Updating the texinfo index"
    update-info-dir ${TPM_TARGET}/usr/share/info/
fi

# If there is no /bin/sh, use this bash for it (required shell by the FHS)
if ! [ -L ${TPM_TARGET}/bin/sh ] && ! [ -e ${TPM_TARGET}/bin/sh ]
then
    ln -s bash ${TPM_TARGET}/bin/sh
fi
