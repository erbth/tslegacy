#!/bin/bash

set -e

umask 0022

# Update the texinfo file index
# if type update-info-dir &> /dev/zero
# then
#     echo -e -n "\n    Updating the texinfo index"
#     update-info-dir ${TPM_TARGET}/usr/share/info/
# fi

# hwdb can only be updated if libblkid from linux-utils has been installed yet
# Therefore the TPM package of linux-utils must contain a postinst script with
# a similar command.
if [ -n "$(find ${TPM_TARGET}/{lib{,64},usr} -name libblkid*)" ]
then
    ${TPM_TARGET}/sbin/udevadm hwdb --update --root=${TPM_TARGET}
fi
