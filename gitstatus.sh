#!/bin/bash
# shows the git status for repositries in specified directory default is cwd
# for a given recursion depth
#
# Sypnosis
# gitstatus [-maxdepth] <integer depth> [<directory>]

if ! [[ "$1" =~ ^-.* ]] && [[ "$#" -gt 0 ]]; then
    COMMITMSGBOO=1
    COMMITMSG=$1
    shift
fi   


for file in 
