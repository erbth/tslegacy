#!/bin/bash

set -e

umask 0022

# Remove the hardware database if it has been created
rm -vf etc/udev/hwdb.bin
