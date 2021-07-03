#!/bin/bash
imgList=/tmp/rndimg.txt
DIR=`pwd -P`

find /mnt/e/Video -name snapsoup | while read -r rndDir
do
  for FILE in "$rndDir"/*.jpg
    do
      echo "$FILE" >> $imgList
    done
done
cat $imgList | sort -R | echo "`head -n 1`"
rm $imgList

#find / -name snapsoup 2>/dev/null
#^^find and all all snapsoup

