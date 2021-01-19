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
	echo "file://$locRSS/$1" >> $locNewsboat/urls
}


function formRSS {
	# $1 = URL
	dataPlaylist=$(downloadYT --skip-download --playlist-item 1 -j $1 | cut -c-1000 | tr " " "\n")
	YTTitle=$(getData "$dataPlaylist" "playlist" "start_time" GET)
	
	rssBody="<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<rss version='2.0'>\n\n<channel>\n"
	rssBody+="\t<title>$YTTitle</title>\n\t<link>$1</link>"
	
	dataVideos="$(downloadYT -j --flat-playlist $1 | tr " " "\n")"
	
	while :; do
		YTVideo=$(getData "$dataVideos" "title" "url" GET)
		dataVideos=$(getData "$dataVideos" "title" "url" CUT)
		
		YTURL=$(getData "$dataVideos" "url" "view_count" GET)
		dataVideos=$(getData "$dataVideos" "url" "view_count" CUT)
		
		YTURLFull="https://www.youtube.com/watch?v=$YTURL"
		
		echo "$YTVideo - $YTURL"
		
		[[ -z $YTURL ]] && break
		
		rssBody+="\n\t<item>\n\t\t<title>$YTVideo</title>\n\t\t<link>$YTURLFull</link>\n\t</item>"
	done
	
	mkdir -p $locRSS
	echo -e "$rssBody\n</channel>\n\n</rss>" > $locRSS/${YTTitle// /_}.rss
	
	RSStoNewsboatURLS ${YTTitle// /_}.rss
}


while :; do
	case $1 in # URL
		*youtube.com*)
			formRSS $1 2> /dev/null
			;;
		*.rss)
			RSStoNewsboatURLS $1
			;;
		*)
			break ;;
	esac
	shift
done
