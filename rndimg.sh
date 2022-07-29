#!/bin/bash

VIDEOFILES=/mnt/e/Video 			#your full path to where you keep your videos, unused
GDIR=`cat /tmp/snapsoup/gdir` #get user specified snapsoup folder
imgList=/tmp/rndimgImgs.txt 	#the full list of images
rndimg=/tmp/rndimg.txt				#the current run output

i=0
ITERATE=1
NAME=""

PRETTY=""
ONLYOUT=""
CAT=""
WSLPATH=""

while getopts ":n:i:cpouw" opt
do
  case $opt in
  	c)
			CAT=true
			;;
  	i)
			ITERATE=$OPTARG
			;;

  	n)
			NAME=$OPTARG
			;;
		p)
			PRETTY=true
			;;
		o)
			ONLYOUT=true
			;;
		u)
			ls -v "$GDIR"/*.jpg > "$imgList" 	#update SLOW!
			echo "update complete"
			exit 1
		  ;;
		w)
			WSLPATH=true
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

if [ "$GDIR" = "" ] 
then
	echo "snapsoup directory not set, have you generated any snapshots?"
	echo "set directory with snapsoup -d </full/path/to/dir>"
	exit
fi

printf "" > $rndimg 2>/dev/null 	#clean prev run

while [ $i -lt $ITERATE ]
	do
		let i=i+1
		cat $imgList | grep "$NAME" --color=never | head -$(echo $(($RANDOM % $(cat $imgList | grep "$NAME" | wc -l) + 1))) | tail -1 >> $rndimg
	done

if [ $CAT ] #cat out for image2pipe
then
	cat $rndimg | while read -r line
	do
		cat "$line"
	done
	exit
fi

if [ "$ONLYOUT" = "" ]
then
	cat $rndimg | while read -r line
	do
		xdg-open "$line"
	done
fi


if [ $WSLPATH ]
then
	cat $rndimg | while read -r line
	do
		wslpath -w "$line"
	done
	exit
fi

if [ $PRETTY ]
then
	cat "$rndimg" | sed "s|$GDIR\/||" | tr _  " " | sed 's/.\{9\}$//' | tr '-' " "
	exit
fi

cat "$rndimg"