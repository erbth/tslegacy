#!/bin/bash

set -e

umask 0022

# Update the texinfo file index
# if type update-info-dir &> /dev/zero
# then
#     echo -e -n "\n    Updating the texinfo index"
#     update-info-dir ${TPM_TARGET}/usr/share/info/
# fi

# Update the shadowed password files if the required tools are installed.
if type pwconv &> /dev/zero
then
    pwconv -R "${TPM_TARGET}"
fi

if type grpconv &> /dev/zero
then
    grpconv -R "${TPM_TARGET}"
fi
