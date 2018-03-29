#!/bin/bash

set -e

umask 0022

# Update the texinfo file index
# if type update-info-dir &> /dev/zero
# then
#     echo -e -n "\n    Updating the texinfo index"
#     update-info-dir ${TPM_TARGET}/usr/share/info/
# fi

# If eudev is installed already, the hwdb needs to be updated since eudev did
# not have the a required library contained in this package.
if [ -x ${TPM_TARGET}/sbin/udevadm ]
then
    ${TPM_TARGET}/sbin/udevadm hwdb --update --root=${TPM_TARGET}
fi
