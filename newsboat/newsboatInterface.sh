#!/bin/bash

# Takes input [action] [VIDEO url] - works on a single video downloading and managing

function manageYoutube {
	# Set basic variables for locations and youtube-dl
	outputLoc="$baseLoc/Videos"; ytdlForm="bestvideo[height<=480]+bestaudio/best[height<=480]"
	
	# Collect video data from youtubeData.txt (the offline title store)
	if [[ -e $baseLoc/.newsboat/youtubeData.txt && "$(cat $baseLoc/.newsboat/youtubeData.txt)" =~ "$2" ]]; then 
		titleData="$(grep -s $2 $baseLoc/.newsboat/youtubeData.txt | tail -1 | cut -f2 -d"|" )" || titleData=""
		titleVideo="$( ls $outputLoc | grep "$titleData" )" || titleVideo=""
		
	else titleData=""; titleVideo=""; fi
	
	case $1 in
	down)
		# If this video's data doesn't exist, add it to the data file
		[[ -n $titleData ]] || echo "$2|$(youtube-dl --get-filename -o "%(title)s" -f $ytdlForm $2)" >> $baseLoc/.newsboat/youtubeData.txt
		
		# Download the video locally
		youtube-dl -q -o "$outputLoc/%(title)s" -f $ytdlForm $2 2> /dev/null &
		;;
		
	open)
		# If video exists locally, open it (and ignore vlc errors)
		[[ -n $titleVideo ]] && vlc "$outputLoc/$titleVideo" 2> /dev/null &
		;;
		
	delete)
		# Test if video exists locally (if not, do nothing)
		if [[ -n $titleVideo ]]; then
			# Get a version of the video data store without this video's data
			newData=$(grep -v "$titleData" $baseLoc/.newsboat/youtubeData.txt)
			
			# Remove local copy of video and, if that is successful, rewrite video's data in data store
			rm "$outputLoc/$titleVideo" && echo $newData > $baseLoc/.newsboat/youtubeData.txt
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
