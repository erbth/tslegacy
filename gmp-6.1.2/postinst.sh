#!/bin/bash

set -e

# Update the texinfo file index
umask 0022
if type update-info-dir ${TPM_TARGET}/usr/share/info/ &> /dev/zero
then
    echo -e -n "\n    Updating the texinfo index"
    update-info-dir
fi
