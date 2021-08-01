#!/bin/bash

VIDEOFILES=/mnt/e/Video 			#your full path to where you keep your videos, unused
GDIR=`cat /tmp/snapsoup/gdir` #get user specified snapsoup folder
imgList=/tmp/rndimgImgs.txt 	#the full list of images
rndimg=/tmp/rndimg.txt				#the current run output

ITERATE=1
NAME=""
PRETTY=""
ONLYOUT=""
WSLPATH=""

while getopts ":n:i:pow" opt
do
  case $opt in
  	n)
			NAME=$OPTARG
			;;
		i)
			ITERATE=$OPTARG
			;;
		p)
			PRETTY=true
			;;
		o)
			ONLYOUT=true
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

ls -v "$GDIR"/*.jpg > "$imgList" 	#get full list, abundant?

printf "" > $rndimg 2>/dev/null 	#clean prev run

cat $imgList | grep "$NAME" --color=never | sort -R | while read -r line
do 
	let i=i+1
	if [ $i -gt $ITERATE ]
		then break;
	fi
	echo "$line" >> $rndimg
done

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