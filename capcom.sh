#!/bin/bash
# This scripts helps to recursively act on all files in a given directory and capturing the expression
# usage capcom com comops root_dir bef_cut/aft_cut nbef_cut/naft_cut
# this code does not work for hidden files; '*' does not handle hidden files

shopt -s globstar nullglob

com=$1
comops=$2
root_dir=$3
bef_aft_cut=$4
nbef_naft_cut=$5

bef_cut=${bef_aft_cut%/*}
aft_cut=${bef_aft_cut#*/}
nbef_cut=${nbef_naft_cut%/*}
naft_cut=${nbef_naft_cut#*/}


for name in $root_dir/**/$bef_cut*$aft_cut; do

    parent_dir=${name%/*}	 # get path of directory
    newname=${name#"$parent_dir/"} # remove parent dir from name

    newname="$nbef_cut"${newname#"$bef_cut"} # remove prefix and add new one
    newname=${newname%"$aft_cut"}"$naft_cut" # remove suffix and add new one
    
    newname="$parent_dir"/$newname # adding back the parent directory

    printf 'acting on "%s" to "%s"\n' "$name" "$newname" # for testing
    "$com" "$comops" "$name" "$newname"
done
