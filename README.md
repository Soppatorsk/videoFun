# videoFun
A collection of various simple bash scripts using [ffmpeg](https://ffmpeg.org/) to make fun/useful stuff with downloaded video content.

**audiocat**
---
Convert and concatenate video files in current directory into one .mp3 file.

Useful for AJATT language learning immersion content. 

`-o <file out directory>`

`-n <name>`

`-f <filetype>`

**rndimg**
---
Get random snapshot image from any video content after running snapsoup

`-i <n>` get n random pictures.

`-n <name>` get pictures from specific name 

`-o` do not open, only output file

`-p` pretty output instead of filepath


**snapsoup**
---
Generate snapshots of all video files in current directory

Usage: `snapsoup -n <name of show>`

`-f <filetype> (default: mkv)`

`-e` enable episode number in filenames

specify directory for snapshots with `snapsoup -d <full/path/to/dir>`



**subfix**
---
renames subtitle files in directory `./subs` to match video files for media player auto-detection

`-f <filetype>` to specify video filetype. (default: mkv) 

`-o <offset>` to skip first `<offset>` number of episodes

test
