changequote(`[',`]')

#!/bin/bash

set -e

umask 0022

define([HANDLE_TEXINFO],
[# Update the texinfo file index
if type update-info-dir &> /dev/zero
then
    echo -e -n "\n    Updating the texinfo index"
    update-info-dir
fi])
