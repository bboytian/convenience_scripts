#!/bin/bash
# usage: mkv2mp4.sh directory (without last forward slash)
# converts all .mkv files in specified directory to .mp4.mkv files

for file in $1/*.mkv
do
	echo "$file"
	ffmpeg -i "$file" -codec copy "$file".mp4
done

#echo 'removing all .mkv files'
#rm $1/*.mkv

#/home/tianli/Admin/convenience_scripts/capmv.sh $1 /mkv /mp4
