#!/bin/bash

# Append this file to ~/.newsboat/urls as file://FILE LOCATION

cleanList=$(youtube-dl -j --flat-playlist $1 | cut -c109- | rev | cut -c43- | rev)

OLDIFS=$IFS; IFS=$'\n'

cleanTitles=($(echo "$cleanList" | cut -c11- | rev | cut -c24- | rev))
cleanURLS=($(echo "$cleanList" | rev | cut -c2-12 | rev))

IFS=$OLDIFS

rssOutput="<?xml version="1.0" encoding="UTF-8" ?>\n<rss version='2.0'>\n\n<channel>\n\t<title>Local feed testing</title>"

for ((i=0 ; i<${#cleanTitles[@]} ; i++)); do
	itemTitle="${cleanTitles[i]}"
	itemURL="${cleanURLS[i]}"
	itemURLfull="https://www.youtube.com/watch?v=$itemURL"
	
	rssOutput="$rssOutput\n\t<item>\n\t\t<title>$itemTitle</title>\n\t\t<link>$itemURLfull</link>\n\t</item>"
done

echo -e "$rssOutput\n</channel>\n\n</rss>"


# TODO
# - Make sure it allows for higher length videos (will mess up the cutting of cleanList)
# - Allow it to be repeated X times
# - Work in newsboat integration (once the configs and stuff are sorted)
