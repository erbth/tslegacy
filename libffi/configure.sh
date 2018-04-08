#!/bin/bash

set -e

umask 0022

# Update the texinfo file index
if type update-info-dir &> /dev/zero
then
    echo -e -n "\n    Updating the texinfo index"
    update-info-dir
fi

# For some reason it seems to be necessary to call ldconfig in order to enable
# linking to the library installed in /usr/lib64.
ldconfig
