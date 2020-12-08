#!/bin/bash

function feedRefresh {
	# Take the RSS feed and extract the main URL from the file
	feedURL=$(head -n 6 $1 | tail -n 1 | cut -c8- | rev | cut -c8- | rev)
	# Run youtubeFeeder with this URL and feed back into the RSS feed
	bash $bashBase/newsboat/youtubeFeeder.sh "$feedURL" > $1
}

while [ $# -gt 0 ]; do feedRefresh "$1"; shift; done
