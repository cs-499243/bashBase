#!/bin/bash
# Append output file to ~/.newsboat/urls as file://FILE LOCATION

# Get playlist json data for a playlist and cut it down to data I use
cleanList=$(youtube-dl -j --flat-playlist $1 | cut -c109- | rev | cut -c43- | rev)
# Change the separator for arrays " " --> "\n" so I can split the data
OLDIFS=$IFS; IFS=$'\n'
# Get a list of titles and URLs from the json data
cleanTitles=($(echo "$cleanList" | cut -c11- | rev | cut -c24- | rev))
cleanURLs=($(echo "$cleanList" | rev | cut -c2-12 | rev))
# Reset separator for arrays
IFS=$OLDIFS

# Start the rss file with basic xlml data
rssTitle="Local Feed Testing"
rssOutput="<?xml version="1.0" encoding="UTF-8" ?>\n<rss version='2.0'>\n\n<channel>\n\t<title>$rssTitle</title>"

# Loop through range(0, len(cleanTitles)) - titles and URLs of same length
for ((i=0 ; i<${#cleanTitles[@]} ; i++)); do
	# Iterate through data arrays and store x item's title and URL (mostly for debug)
	itemTitle="${cleanTitles[i]}"
	itemURL="${cleanURLs[i]}"
	# Make a full URL out of the stored data
	itemURLfull="https://www.youtube.com/watch?v=$itemURL"
	# Add an rss item for each item in arrays
	rssOutput="$rssOutput\n\t<item>\n\t\t<title>$itemTitle</title>\n\t\t<link>$itemURLfull</link>\n\t</item>"
done

# Output the complete rss file - Can now be piped into a file
echo -e "$rssOutput\n</channel>\n\n</rss>"


# TODO
# - Make sure it allows for higher length videos (will mess up the cutting of cleanList)
# - Allow it to be repeated X times
# - Work in newsboat integration (once the configs and stuff are sorted)
