#!/bin/bash

set -e

# Update the texinfo file index
umask 0022
if type update-info-dir &> /dev/zero
then
    echo -e -n "\n    Updating the texinfo index"
    update-info-dir
fi

# If there is no /bin/sh, use this bash for it (required shell by the FHS)
if ! [ -L /bin/sh ] && ! [ -e /bin/sh ]
then
    ln -s bash /bin/sh
fi
