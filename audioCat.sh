C=0

G='\033[1;32m'
B='\033[1;34m'
N='\033[0m' #none

FILETYPE=mkv
TMPDIR=/tmp/audioCat
OUTDIR=/mnt/e/Audio
NAME="finalaudio"
mkdir $TMPDIR 2>/dev/null
while getopts ":f:n:o:h" opt; do
  case $opt in
    f)
      FILETYPE=$OPTARG >&2
      ;;
    n)
NAME=$OPTARG
;;
o)
OUTDIR=$OPTARG
;;
    h)
      echo "audioCat by https://github.com/Soppatorsk/audioCat"
      echo "-f <video_filetype> default: mkv" >&2
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

for FILE in *.$FILETYPE #does this really get the right order?
do
        let C=C+1
        ffmpeg -loglevel quiet -i "$FILE" $TMPDIR/$C.wav
done
sox $(ls -v $TMPDIR/*.wav) $TMPDIR/finalaudio.wav
ffmpeg -loglevel quiet -i $TMPDIR/finalaudio.wav $OUTDIR/"$NAME.mp3"

printf "\n${B}$NAME${N} is Done! \n"

rm -rf $TMPDIR/*