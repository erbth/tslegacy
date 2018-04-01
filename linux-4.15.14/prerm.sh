#!/bin/bash

set -e

umask 0022

# Update the texinfo file index
# if type update-info-dir &> /dev/zero
# then
#     echo -e -n "\n    Updating the texinfo index"
#     update-info-dir ${TPM_TARGET}/usr/share/info/
# fi

# Remove modules.dep and map files
rm -f "${TPM_TARGET}"/lib/modules/4.15.14/modules.{alias{,.bin},\
builtin.bin,dep{,.bin},devname,softdep,symbols{,.bin}}
