#!/bin/bash

set -e

umask 0022

# Update the texinfo file index
# if type update-info-dir &> /dev/zero
# then
#     echo -e -n "\n    Updating the texinfo index"
#     update-info-dir ${TPM_TARGET}/usr/share/info/
# fi

# Remove the hardware database if it has been created
rm -vf ${TPM_TARGET}/etc/udev/hwdb.bin
