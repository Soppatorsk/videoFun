#!/bin/bash
dirList=/tmp/rndimgDirs.txt
imgList=/tmp/rndimgImgs.txt
VIDEOFILES=/mnt/e/Video #your full path to where you keep your videos

rndimg=/tmp/rndimg.txt
rm $rndimg 2>/dev/null
cat $imgList 2>/dev/null | sort -R | head -n 1 > $rndimg

while getopts ":l:s:cnowq" opt; 
do
  case $opt in
  	l) #loop for i
	i=1
	cat $imgList | sort -R | while read -r line
	do 
		let i=i+1
		if [ $i -gt $OPTARG ]
			then break;
		fi
		echo "$line" >> $rndimg
	done
	;;
  	c) #only current snapsoup, not compatible with l
	rm $rndimg
	echo `ls snapsoup/*.jpg | sort -R | head -n 1` >> $rndimg 
	;;
  n) #nice readable output
  cat --number $rndimg | sed 's/\/mnt\/e\/Video\/Anime\/Series\///' | sed 's/\/mnt\/e\/Video\/Anime\/Movies\///' | sed 's/\/snapsoup\//\t/'
  exit 1
  ;;
    s) #scan
	echo "$OPTARG"
	 rm $imgList 2>/dev/null
	 rm $dirList 2>/dev/null
     find "$OPTARG" -name snapsoup 2>/dev/null | while read -r rndDir
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
	cat $rndimg | sed 's/\/mnt\/e/E:/'
	exit 1
	;;
	q)
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

cat "$rndimg"
#rm $rndimg
