#!/bin/bash
# This script helps to more conveniently run nested python scripts which require relative imports
# usage:
# 0. bash_alises created for this script
# 1. cd to parent directory
# 2. pythonm [-i] /path/to/fileORmodule

INTERACTIVEBOO=0

# parsing arguments
if [[ "$#" -gt 2 ]]; then
    echo 'too many arguments'
    exit 1
fi


while [[ "$#" -gt 0 ]]; do
    case $1 in
	-i|--interactive)
	    INTERACTIVEBOO=1
	    ;;
	-*)
	    echo "invalid flag: $1"
	    ;;
	*)
	    SCRIPTSTR=$1
	    ;;
    esac
    shift
done

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
if [ $INTERACTIVEBOO == 1 ]; then
    python -i -m $SCRIPTSTR
else
    python -m $SCRIPTSTR
fi
