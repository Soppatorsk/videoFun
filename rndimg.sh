#!/bin/bash
imgList=/tmp/rndimg.txt
VIDEOFILES=/mnt/e/Video #your full path to your video files
DIR=`pwd -P`

find $VIDEOFILES -name snapsoup 2>/dev/null | while read -r rndDir
do
  for FILE in "$rndDir"/*.jpg
    do
      echo "$FILE" >> $imgList
    done
done
IMG=`cat $imgList | sort -R | head -n 1`
xdg-open "$IMG"
rm $imgList
