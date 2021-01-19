function bashRelay {
	relayListing=$(find $bashBase -name "*.sh"); relayListing="${relayListing//$bashBase/}"

	if [[ -n $1 ]]
		then fileAction=$1; shift
		else echo $relayListing | tr " " "\n"; return; fi

	bash $bashBase/$fileAction $@ || echo -e " - FAILED\n$relayListing"; }


function ad_auto { bashRelay listerFix/listerFix.sh $@; }
function ad_series { bashRelay listerFix/listerFix_series.sh $@; }

function youtube480 { [[ -n $1 ]] && youtube-dl -o "%(title)s" -f "bestvideo[height<=480]+bestaudio/best[height<=480]" $1; }

function newk {
	[[ -n $1 ]] || return
	konsole -e "$@" &
	disown
	}
