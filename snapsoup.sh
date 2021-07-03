#!/bin/bash
C=0
FILETYPE=mkv
DIR=./snapsoup
mkdir $DIR
rm -rf $DIR/*
while getopts ":f:t" opt; do
  case $opt in
    f)
      FILETYPE=$OPTARG >&2
      ;;
    t)
      echo $PWD
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

for FILE in *.$FILETYPE;
do
  let C=C+1
	ffmpeg -i "$FILE" -r 0.1 "$DIR"/"$C"%04d.jpg
done
#skip intro outro?
