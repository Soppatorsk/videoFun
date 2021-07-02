#!/bin/bash
imgList=/tmp/imgrnd.txt
DIR=`pwd -P`
while getopts ":a" opt; do
  case $opt in
    a)
    echo "export RNDIMG=\"\$RNDIMG`pwd -P`/snapsoup:\""
		exit 1
		;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

printenv RNDIMG | tr ':' '\n' | while IFS= read -r rndDir
do
  for FILE in "$rndDir"/*.jpg
    do
      echo "$FILE" >> $imgList
    done
done
cat $imgList | sort -R | echo "`head -n 1`"
rm $imgList
#current dir
#wslview snapsoup/`ls snapsoup | sort -R | head -n 1`

