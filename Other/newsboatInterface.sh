#!/bin/bash

function manageYoutube {
	# Set basic variables for locations and youtube-dl
	outputLoc="$baseLoc/Videos"; ytdlForm="bestvideo[height<=480]+bestaudio/best[height<=480]"
	# Collect video data from youtubeData.txt (the offline title store)
	videoData=$(grep -s $2 $baseLoc/.newsboat/youtubeData.txt | tail -1)
	# If this video's data exists, see if the video exists locally
	[[ -n $videoData ]] && videoTitle=$(ls $outputLoc | grep -s "$(echo "$videoData" | sed 's/[^|]*|//')")
	
	# Allow different methods for youtube URLS
	case $1 in
	down)
		# If this video's data doesn't exist, add it to the data file
		[[ -z $videoData ]] && echo "$2|$(youtube-dl --get-filename -o "%(title)s" -f $ytdlForm $2)" >> $baseLoc/.newsboat/youtubeData.txt
		# Download the video locally
		youtube-dl -q --no-warnings -o "$outputLoc/%(title)s" -f $ytdlForm $2 &
		;;
	open)
		# If video exists locally, open it (and ignore vlc errors)
		[[ -n $videoTitle ]] && vlc "$outputLoc/$videoTitle" 2> /dev/null &
		;;
	delete)
		# Test if video exists locally (if not, do nothing)
		if [[ -n $videoTitle ]]; then
			# Get a version of the video data store without this video's data
			newData=$(grep -v "$videoData" $baseLoc/.newsboat/youtubeData.txt)
			# Remove local copy of video and, if that is successful, rewrite video's data in data store
			rm "$outputLoc/$videoTitle" && echo $newData > $baseLoc/.newsboat/youtubeData.txt
		fi
		;;
	*)
		echo "Invalid input - $1"
		;;
	esac
	}

# Give different ouputs for different web services
[[ "$2" =~ "youtube.com" ]] && echo "$2 - youtube link"; manageYoutube $1 $2
[[ "$2" =~ "nitter.net" ]] && echo "$2 - nitter/twitter link"
[[ "$2" =~ "file://" ]] && echo "$2 - local file link"
