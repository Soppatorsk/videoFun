C=0
FILETYPE=mkv
mkdir tmp

while getopts ":f:h" opt; do
  case $opt in
    f)
      FILETYPE=$OPTARG >&2
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

for FILE in *.$FILETYPE
do
        let C=C+1
        ffmpeg -i "$FILE" tmp/$C.wav
done
sox $(ls -v tmp/*.wav) tmp/finalaudio.wav
ffmpeg -i tmp/finalaudio.wav finalAudio.mp3
rm -rf tmp

#Takes mkv files in current directory and converts and concatinates them into a single .mp3 file