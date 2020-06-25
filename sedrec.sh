#!/bin/bash
#
# recursive sed -i on specified directory
# this command is POWERFUL be very careful when using
#
# For sed argument:
# to delete line containing input '/.*input.*/d'
# to replace input with output 's/input/output/g'
#
# Sypnosis
# sedrec <working dir> <sed expression>

if [[ "$#" -lt 2 ]]; then
    echo "missing arguments"
    exit 1
else
    find "$1" \( -type d -name .git -prune \) -o -type f -print0 | \
	xargs -0 sed -i "$2"
fi
