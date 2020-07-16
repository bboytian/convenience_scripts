#!/bin/bash
# This script helps to more conveniently run nested python scripts which require relative imports
# usage:
# 0. bash_alises created for this script
# 1. cd to parent directory
# 2. pythonm [options] /path/to/fileORmodule

while [[ "$#" -gt 1 ]]; do
    flags="$flags $1"
    shift
done


SCRIPTSTR=$1
# parsing the directory for mudular input
if [ "${SCRIPTSTR:$(expr ${#SCRIPTSTR} - 1):1}" = '/' ] # py module
then
   SCRIPTSTR="${SCRIPTSTR:0:$(expr ${#SCRIPTSTR} - 1)}"
elif [ "${SCRIPTSTR:$(expr ${#SCRIPTSTR} - 3):3}" = '.py' ] #py script
then
    SCRIPTSTR="${SCRIPTSTR:0:$(expr ${#SCRIPTSTR} - 3)}"
fi
SCRIPTSTR=$(echo $SCRIPTSTR | sed -e 's/\//\./g')

# running
python $flags -m $SCRIPTSTR

