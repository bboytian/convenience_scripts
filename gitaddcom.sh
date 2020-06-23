#!/bin/bash
# SYNOPSIS
# gitaddcom [-a <files to add to index> --] [-p] [<commit message>] 


ADDALLBOO=1
PUSHBOO=0
COMMITMSGBOO=0

# if ! [[ "$1" =~ ^-.* ]] && [[ "$#" -gt 0 ]]; then
#     COMMITMSGBOO=1
#     COMMITMSG=$1
#     shift
# fi   

while [[ "$#" -gt 0 ]]; do
    case $1 in
	-a|--add)
	    echo "adding files..."
	    ADDALLBOO=0
	    while ! [[ "$2" =~ ^-.* ]] && [[ "$#" -gt 1 ]]; do
		echo -e "\t $2"
		git add $2
		shift

		if [[ "$2" == -- ]]; then
		    shift
		    break
		fi
	    done
	    ;;
	-p|--push)
	    PUSHBOO=1
	    ;;
	-*)
	    echo "invalid flag: $1"
	    exit 1
	    ;;
	*)
	    echo "this worked"
	    COMMITMSGBOO=1
	    COMMITMSG=$1
	    ;;
    esac
shift
done


if [ $ADDALLBOO == 1 ]; then
    echo "adding every file to index..."
    git add .
fi

if [ $COMMITMSGBOO == 1 ]; then
    echo "commiting..."
    git commit -m "$COMMITMSG"
else
    echo "prompt for commit message..."
    git commit
fi    

if [ $PUSHBOO == 1 ]; then
    echo "performing push to upstream remote branch..."
    git push
fi
