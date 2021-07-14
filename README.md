# videoFun
A collection of various simple bash scripts using [ffmpeg](https://ffmpeg.org/) to make fun/useful stuff with downloaded video content.

**audiocat**
---
Convert and concatenate video files in current directory into one .mp3 file.

Useful for AJATT language learning and immersion content. 


**rndimg**
---
Get random snapshot image from any video content after running snapsoup

`-s <full path>` search for snapsoup directories (do this first)

`-l <n>` get n random pictures.

`-c` only generate from current snapsoup directory

`-o` open images with xdg-open


**snapsoup**
---
Generate snapshots of all video files in current directory


**subfix**
---
renames subtitle files in directory 'subs' to match video files for media player auto-detection

`-f <filetype>` to specify video filetype. (default: mkv) 

`-o <offset>` for when missing n number of episodes (If you dont keep all 200+500 episodes of naruto on your drive at once, ex.)
