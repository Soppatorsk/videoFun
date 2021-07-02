#!/bin/bash
TMPD=/tmp/subfix
FILETYPE=mkv
C=0
mkdir $TMPD
SUBLIST=$TMPD/subs.txt

while getopts ":f:o:h" opt; do
  case $opt in
    o)
	C=$OPTARG >&2
	;;
    f)
      FILETYPE=$OPTARG >&2
      ;;
    h)
      echo "subNameFix by https://github.com/Soppatorsk/subNameFix"
      echo "-f <video_filetype> default: mkv" >&2
      echo "-o <offset> if missing the first n number of episodes"
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

ls -v subs/*.srt > $SUBLIST
sed -e '1,'$C'd' $SUBLIST
ls -v *.$FILETYPE | sed 's/.'$FILETYPE'//' | while IFS= read -r line
do
  let C=C+1
  mv "$(sed ''$C'q;d' $SUBLIST)" subs/"$line".srt
done
rm -rf /tmp/subfix
