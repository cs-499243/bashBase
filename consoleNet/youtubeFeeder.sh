locNewsboat=$HOME/.newsboat
locRSS=$HOME/.newsboat/RSS

function downloadYT { [[ -n $1 ]] &&  youtube-dl -q $@; }

function getData {
	# $1 = YTData, $2 = item, $3 = following item, $4 = setting
	
	# Find key lines in the feed
	feedNStart=$(echo -e "$1" | grep -n -m 1 "$2\"" | cut -d : -f 1)
	feedNEnd=$(echo -e "$1" | grep -n -m 1 "$3\"" | cut -d : -f 1)
	
	feedStart=$((feedNEnd - 1))
	
	case $4 in # Setting
		GET) 
			feedEnd=$((feedNEnd - feedNStart - 1))
			# Extract out the specific lines
			feedData=$(echo -e "$1" | head -n $feedStart | tail -n $feedEnd )
			# Remove the " and ": at the ends of the string
			echo -e $feedData | cut -c 2- | rev | cut -c 3- | rev
			;;
		CUT)
			feedEnd=$(echo -e "$1" | wc -l)
			echo -e "$1" | tail -n $((feedEnd - feedStart)) 
			;;
		*) ;;
	esac
}


function RSStoNewsboatURLS {
	# $1 = filename
	touch $locNewsboat/urls
	[[ -n $(cat $locNewsboat/urls | grep $1) ]] && return
	echo "file://$locRSS/$1" >> $locNewsboat/urls
}


function formRSS {
	# [$2 = FORM, $1 = URL] - [$2 = UPDATE_int, $1 = RSS]
	case $2 in
	FORM)
		dataPlaylist=$(downloadYT --skip-download --playlist-item 1 -j $1 | cut -c-1000 | tr " " "\n" | tr "/" " ")
		
		YTTitle=$(getData "$dataPlaylist" "playlist" "start_time" GET)
		
		rssHead="<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<rss version='2.0'>\n\n<channel>\n"
		rssBody="\t<title>$YTTitle</title>\n\t<link>$1</link>"
		rssTail="\n</channel>\n\n</rss>"
		
		dataVideos="$(downloadYT -j --flat-playlist $1 | tr " " "\n")"
		;;
	*)
		YTTitle=$(sed -n '5p' $1 | cut -c 9- | rev | cut -c 9- | rev)
		YTUrl=$(sed -n '6p' $1 | cut -c 8- | rev | cut -c 8- | rev)
		
		rssHead=$(head -6 $1)
		rssLength=$(cat $1 | wc -l)
		rssTail="\n$(tail -$rssLength $1)"
		# TODO Fix this bit
		
		dataVideos="$(downloadYT -j --flat-playlist $YTUrl | tr " " "\n")"
		[[ "$2" != 0 ]]  && dataVideos=$(echo -e "$dataVideos" | cut -c-$2)
		
		;;
	esac
	
	while :; do
		YTVideo=$(getData "$dataVideos" "title" "url" GET)
		dataVideos=$(getData "$dataVideos" "title" "url" CUT)
		
		YTURL=$(getData "$dataVideos" "url" "view_count" GET)
		dataVideos=$(getData "$dataVideos" "url" "view_count" CUT)
		
		YTURLFull="https://www.youtube.com/watch?v=$YTURL"
		
		echo "$YTTitle - $YTVideo - $YTURL"
		
		[[ -z $YTURL ]] && break
		
		[[ -n $(echo -e "$rssTail" | grep "$YTURL</link>") ]] && continue
		
		rssBody+="\n\t<item>\n\t\t<title>$YTVideo</title>\n\t\t<link>$YTURLFull</link>\n\t</item>"
	done
	
	mkdir -p $locRSS
	echo -e "$rssHead$rssBody$rssTail" > $locRSS/${YTTitle// /_}.rss
	
	RSStoNewsboatURLS ${YTTitle// /_}.rss
}

while :; do
	case $1 in 
		*youtube.com*)
			formRSS $1 FORM #2> /dev/null
			;;
		*.rss)
			formRSS $1 0
			;;
		UPDATE) # Now $2 is URL
			fileLoc=$(grep -l -r "$2" $locRSS)
			formRSS $fileLoc 0
			;;
		FULL_UPDATE)
			fileLoc=$(grep -l -r "$2" $locRSS)
			formRSS $fileLoc 10000
			;;
		*)
			break ;;
	esac
	shift
done

#TODO
# - Do not write no-title videos to youtubeData
# - Extend to allow any feeds to be parsed - separate out the feed reading/writing part
