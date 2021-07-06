#!/bin/bash
dirList=/tmp/rndimgDirs.txt
imgList=/tmp/rndimgImgs.txt
VIDEOFILES=/mnt/e/Video #your full path to where you keep your videos

rndimg=/tmp/rndimg.txt

cat $imgList | sort -R | head -n 1 > $rndimg

while getopts ":l:cosw" opt; 
do
  case $opt in
  	l) #loop for i
	i=0
	cat $imgList | sort -R | while read -r line
	do 
		let i=i+1
		if [ $i -gt $OPTARG ]
			then break;
		fi
		echo "$line" >> $rndimg
	done
	;;
  	c) #only current snapsoup
	echo `ls snapsoup/*.jpg | sort -R | head -n 1`
    exit 1
	;;
    s) #scan
	 rm $imgList
	 rm $dirList
     find $VIDEOFILES -name snapsoup 2>/dev/null | while read -r rndDir
     do
     	echo "$rndDir" >> $dirList
     	for FILE in "$rndDir"/*.jpg
     		do
     			echo "$FILE" >> $imgList
     		done
     done
     cat $dirList
     exit 1
      ;;
    o)
	cat $rndimg | while read -r line
	do
		xdg-open "$line"
	done
	;;
    w) #win path, not universal.
	echo $IMG | sed 's/\/mnt\/e/E:/'
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

cat $rndimg
#xdg-open "$IMG"
rm $rndimg

