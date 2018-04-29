#!/bin/bash

for FILE in $(find -type f -a ! -path \*/playground/\* -a ! -name show_todos.sh | sort)
do
    grep -n -H --color=always TODO $FILE
done
