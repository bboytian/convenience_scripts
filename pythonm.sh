#!/bin/bash
# This script helps to more conveniently run nested python scripts which require relative imports
# usage:
# 0. bash_alises created for this script
# 1. cd to parent directory
# 2. pythonm /path/to/fileORmodule

script_str=$1

if [ "${script_str:$(expr ${#script_str} - 1):1}" = '/' ] # py module
then
   script_str="${script_str:0:$(expr ${#script_str} - 1)}"
elif [ "${script_str:$(expr ${#script_str} - 3):3}" = '.py' ] #py script
then
    script_str="${script_str:0:$(expr ${#script_str} - 3)}"
fi

echo $script_str | sed -e 's/\//\./g' | xargs python -m
