# CONFIG
locNewsboat=$HOME/.newsboat
locVideos=$HOME/Videos

youtubeFormat="bestvideo[height<=480]+bestaudio/best[height<=480]"


function downloadYT { [[ -n $1 ]] && youtube-dl -q -f $youtubeFormat $@; }

function _getTitle {
	# $1 = URL - youtubeData formatted as "URL|TITLE"
	touch $locNewsboat/youtubeData.txt
	fTitle=$(grep -s "$1" $locNewsboat/youtubeData.txt | cut -f2 -d"|" || echo "")
	echo $fTitle; }

function _getTitleYT { echo $(downloadYT -o "%(title)s" --get-filename $1); }



function _addDownloaded {
	# $1 = URL ;  
	echo "$1|$(_getTitleYT $1)" >> $locNewsboat/youtubeData.txt; }

function _rmDownloaded {
	# $1 = video title
	cp $locNewsboat/youtubeData.txt $locNewsboat/youtubeDataProcessing.txt
	grep -v "$1" $locNewsboat/youtubeDataProcessing.txt > $locNewsboat/youtubeData.txt
	rm $locNewsboat/youtubeDataProcessing.txt; }



function _addBrowserMacro {
	# $1 = key, $2 = command
	echo "macro $1 set browser \"$2\" ; open-in-browser ; set browser firefox " >> $locNewsboat/config; }

function addURL {
	# $1 = URL
	[[ -n $1 ]] || return
	touch $locNewsboat/urls; echo $1 >> $locNewsboat/urls; }



function _ytManage {
	# $1 = COMMAND, $2 = URL
	vidTitle=$(_getTitle $2) # Get title from the record file
	vidFile=$(ls $locVideos | grep "$vidTitle" | tail -1)
	
	echo $vidTitle
	
	case $1 in
		GET)
			if [[ -n $vidTitle ]]; then
				: # Do nothing
			else
				_addDownloaded $2
				downloadYT -o "$locVideos/%(title)s" $2 2> /dev/null &
			fi ;;
		OPEN)
			if [[ -n $vidTitle ]]; then
				mpv "$locVideos/$vidFile" 2&> /dev/null &
			else
				: # Do nothing
			fi ;;
		DELETE)
			if [[ -n $vidTitle ]]; then
				rm "$locVideos/$vidFile"
				_rmDownloaded $vidTitle
			else
				: # Do nothing
			fi ;;
		*)
			echo "INVALID COMMAND" ;;
	esac
	}


function _setDefConfig {
	selfLoc="$bashBase/consoleNet/newsboatInterface.sh"
	
	echo "max-items 0" > $locNewsboat/config
	echo "auto-reload yes" >> $locNewsboat/config
	echo "browser firefox" >> $locNewsboat/config
	_addBrowserMacro "y" "bash $selfLoc GET"
	_addBrowserMacro "u" "bash $selfLoc OPEN"
	_addBrowserMacro "d" "bash $selfLoc DELETE"
	}


case $1 in # SETTING
	CONFIG) 
		_setDefConfig ;;
	ADD) 
		addURL $2 ;;
	*) 
		case $2 in # URL
			*www.youtube.com*) _ytManage $1 $2 ;;
			nitter.net*) ;;
			file:/*) ;;
			*) ;;
		esac ;;
esac





#  >> $locNewsboat/youtubeData.txt;
