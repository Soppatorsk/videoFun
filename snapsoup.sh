#!/bin/bash

#color output
G='\033[1;32m'
B='\033[1;34m'
N='\033[0m' #none

C=0

SSTMP=/tmp/snapsoup
GDIRPATH=$SSTMP/gdir
GDIR=`cat $GDIRPATH 2>/dev/null`
FILETYPE="mkv"
NAME=""

mkdir $SSTMP 2>/dev/null && chmod 777 $SSTMP 2>/dev/null 

while getopts ":d:f:n:e" opt; do
  case $opt in
    d)
	echo $OPTARG > $GDIRPATH;
	echo directory set!
	exit 1;
      ;;
      f)
	FILETYPE=$OPTARG
	;;
	n)
NAME=$OPTARG
if [ NAME == "" ]; then
	echo "Must specify name with -n <name>"
	exit 1
fi
;;
e)
EPISODES="TRUE"
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

for FILE in *.$FILETYPE;
	do
	 	let C=C+1
	 	echo "Generating episode $C..."
	 	#echo "$FILE" -r 0.1 "$GDIR"/"$NAME""-""E`printf %03d $C`""-"%04d.jpg
	 	if [ $EPISODES ]; then
		ffmpeg -loglevel quiet -i "$FILE" -r 0.05 "$GDIR"/"$NAME"" ""E`printf %03d $C`"" "%04d.jpg 
	 	else 
		ffmpeg -loglevel quiet -i "$FILE" -r 0.05 "$GDIR"/"$NAME"" "%04d.jpg 
	fi

	 		
	done
printf "\n${B}$NAME${N} is Done! \n"
printf "Find your snapshots at: ${G}$GDIR${N}\n"

#anime OP skip
#rate of snapshots, estimate disk usage and confirm
#set directory/set and move to directory
#find right filetype, nested if mkv->avi->mp4->...
#get name from directory



