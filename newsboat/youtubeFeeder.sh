#!/bin/bash
# Append output file to ~/.newsboat/urls as file://FILE LOCATION

function feedCreate {
	# Set a title for the feed and basic data for the start of the file
	rssTitle="$(youtube-dl --skip-download --playlist-item 1 -j $1 | cut -f13 -d"," | cut -c15- | rev | cut -c2- | rev)"
	rssOutput="<?xml version="1.0" encoding="UTF-8" ?>\n<rss version='2.0'>\n\n<channel>\n\t<title>$rssTitle</title>\n\t<link>$1</link>"

	# Change the separator for arrays " " --> "\n" so I can split the data
	OLDIFS=$IFS; IFS=$'\n'
	# Get playlist json data for a playlist and store as an array (split by "\n")
	dataList=($(youtube-dl -j --flat-playlist $1))
	# Reset separator for arrays, to be clean
	IFS=$OLDIFS

	# Loop through each item in json data list individually
	for ((i=0 ; i<${#dataList[@]} ; i++)); do
		# Set a temporary item for each item in the list (fastest method, for some reason)
		dataItem="${dataList[i]}"
		
		# Loop for arbitrary number of times to correct potential errors
		for looper in {6..50}; do
			# Cut "title" between occurances of commas (between fixed 6 and an increasing upper bound) - accounts for titles with commas in them
			dataTitle="$(echo $dataItem | cut -f6-$looper -d",")"
			# Cut "URL" similarly but just take the occurance after the title is done
			dataURL="$(echo $dataItem | cut -f$(expr $looper + 1) -d",")"
			# Check if URL is "full" (data will have 4 speech marks present). If not, loop
			checkURL="${dataURL//[^\"]}"; [[ "${#checkURL}" == "4" ]] && break
		done
		
		# Clean up title and URL more to get the most basic data - here so it isn't repeated
		cleanTitle="$(echo $dataTitle | cut -c11- | rev | cut -c2- | rev)"
		cleanURL="$(echo $dataURL | cut -c9- | rev | cut -c2- | rev)"
		# Make a full URL out of the clean copy - separate for debugging
		fullURL="https://www.youtube.com/watch?v=$cleanURL"
		# Add in an RSS entry for each full item in the array
		rssOutput="$rssOutput\n\t<item>\n\t\t<title>$cleanTitle</title>\n\t\t<link>$fullURL</link>\n\t</item>"
	done

	# Output the complete rss file as a file named after the title (spaces replaced by underscores)
	echo -e "$rssOutput\n</channel>\n\n</rss>" > ${rssTitle// /_}.rss
}

# Allow for multiple feeds to be created at once
while [ $# -gt 0 ]; do 
	feedCreate "$1" &
	shift; done

# TODO
# - Allow it to be repeated X times
# - Work in newsboat integration (once the configs and stuff are sorted)
