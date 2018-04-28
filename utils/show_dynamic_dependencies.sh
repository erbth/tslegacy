#!/bin/bash

find -exec objdump -p {} ';' 2> /dev/zero | grep NEEDED | awk '{print $2}' | sort | uniq
