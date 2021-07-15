#!/bin/bash

#color output
G='\033[1;32m'
B='\033[1;34m'
N='\033[0m' #none

C=0

SSTMP=/tmp/snapsoup
GDIRPATH=$SSTMP/gdir
GDIR=`cat $GDIRPATH 2>/dev/null`
LOGLEVEL="loglevel quiet"

NAME="$1"

mkdir $SSTMP 2>/dev/null && chmod 777 $SSTMP 2>/dev/null 

while getopts ":d:" opt; do
  case $opt in
    d)
	echo $OPTARG > $GDIRPATH;
	echo directory set!
	exit 1;
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

if [ $(cat $GDIRPATH) ]; then	
		echo "" >/dev/null # do nothing
else
		echo "snapsoup directory not set! use -d <full path> to specify where you want to store your pictures."  
fi 2>/dev/null

if [ "$1" = "" ]
then
  echo "Usage: snapsoup <Name_Of_Show>"
  exit
fi

for FILE in *.mkv;
	do
	 	let C=C+1
	 	echo "Generating episode $C..."
	 	#echo "$FILE" -r 0.1 "$GDIR"/"$NAME""-""E`printf %03d $C`""-"%04d.jpg
		ffmpeg -loglevel quiet -i "$FILE" -r 0.05 "$GDIR"/"$NAME""-""E`printf %03d $C`""-"%04d.jpg 
	done
printf "\n${B}$NAME${N} is Done! \n"
printf "Find your snapshots at: ${G}$GDIR${N}\n"

#anime OP skip
#rate of snapshots, estimate disk usage and confirm
#set directory/set and move to directory
#find right filetype, nested if mkv->avi->mp4->...
#



