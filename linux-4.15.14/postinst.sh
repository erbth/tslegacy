#!/bin/bash

set -e

umask 0022

# Update the texinfo file index
# if type update-info-dir &> /dev/zero
# then
#     echo -e -n "\n    Updating the texinfo index"
#     update-info-dir ${TPM_TARGET}/usr/share/info/
# fi

# Generate modules.dep and map files
case "$(dirname "${TPM_TARGET}")"
in
    "." | "/")
        depmod -a 4.15.14
        ;;

    *)
        chroot "${TPM_TARGET}" depmod -a 4.15.14
        ;;
esac