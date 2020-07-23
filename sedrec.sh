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
# sedrec <working dir> [-x <exclude phrase> ... -- ] <sed expression>

if [[ "$#" -lt 2 ]]; then
    echo "missing arguments"
    exit 1
fi

XBOO=0
WD=$1
shift

while [[ "$#" -gt 0 ]]; do
    case $1 in
	-x|--exclude)
	    echo 'excluding patterns in path...'
	    XBOO=1
	    while ! [[ "$2" =~ ^-.* ]] && [[ "$#" -gt 1 ]]; do
		echo -e "\t excluding $2"
		if [ -z $REVGREPSTR ]; then
		    REVGREPSTR=$2
		else
		    REVGREPSTR="$REVGREPSTR\|$2"
		fi
		shift
	    done
	    ;;
	--)
	    ;;
	-*)
	    echo "invalid flag: $1"
	    exit 1
	    ;;
	*)
	    SEDSTR=$1
	    ;;
    esac
    shift
done

if [[ $XBOO == 1 ]]; then
    find $WD -type f | grep -v -G "$REVGREPSTR" | xargs sed -i "$SEDSTR"
else
    find $WD -type f | xargs sed -i "$SEDSTR"
fi


# old code
# if [[ "$#" -lt 2 ]]; then
#     echo "missing arguments"
#     exit 1
# else
#     find "$1" \( -type d -name .git -prune \) -o -type f -print0 | \
#	xargs -0 sed -i "$2"
# fi
