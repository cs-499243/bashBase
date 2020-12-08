#!/bin/bash

function manageYoutube {
	outputLoc="$baseLoc/Videos"; ytdlForm="bestvideo[height<=480]+bestaudio/best[height<=480]"
	videoData=$(grep -s $2 $baseLoc/.newsboat/youtubeData.txt | tail -1)
	[[ -n $videoData ]] && videoTitle=$(ls $outputLoc | grep -s "$(echo "$videoData" | sed 's/[^|]*|//')")
	
	case $1 in
	down)
		[[ -z $videoData ]] && echo "$2|$(youtube-dl --get-filename -o "%(title)s" -f $ytdlForm $2)" >> $baseLoc/.newsboat/youtubeData.txt
		
		youtube-dl -q --no-warnings -o "$outputLoc/%(title)s" -f $ytdlForm $2 &
		;;
	open)
		[[ -n $videoTitle ]] && vlc "$outputLoc/$videoTitle" 2> /dev/null &
		;;
	delete)
		echo $videoTitle
		if [[ -n $videoTitle ]]; then
			newData=$(grep -v "$videoData" $baseLoc/.newsboat/youtubeData.txt)
			rm "$outputLoc/$videoTitle" && echo $newData > $baseLoc/.newsboat/youtubeData.txt
		fi
		;;
	*)
		echo "Invalid input - $1"
		;;
	esac
	}


[[ "$2" =~ "youtube.com" ]] && echo "$2 - youtube link"; manageYoutube $1 $2
[[ "$2" =~ "nitter.net" ]] && echo "$2 - nitter/twitter link"
[[ "$2" =~ "file://" ]] && echo "$2 - local file link"
