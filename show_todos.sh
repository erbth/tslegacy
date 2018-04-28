#!/bin/bash

for FILE in $(find -type f -a ! -path \*/playground/\* | sort)
do
    grep -n -H --color=always TODO $FILE
done
