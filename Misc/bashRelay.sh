function bashRelay {
	relayListing=$(find $bashBase -name "*.sh"); relayListing="${relayListing//$bashBase/}"

	if [[ -n $1 ]]
		then fileAction=$1; shift
		else echo $relayListing | tr " " "\n"; return; fi

	bash $bashBase/$fileAction $@ || echo -e " - FAILED\n$relayListing"; }


function ad_auto { bashRelay listerFix/listerFix.sh $@; }
function ad_series { bashRelay listerFix/listerFix_series.sh $@; }

function fls { find -L $1; }

function q {
	# e.g. "gdo ls -lahtr FILE"
	[[ -n $1 ]] || return
	doAct=$(echo -e $@ | rev | cut -d' ' -f2- | rev);
	doTarget=$(echo -e $@ | rev | cut -d' ' -f1 | rev);
	doTo=$(ls | grep -i "$doTarget" | head -n 1)
	[[ -n $doTo ]] && $doAct "$doTo"
}

function qrm {
	[[ -n $1 ]] || return
	rmRemove=$(ls | grep -i "$1" | head -n 1)
	[[ -n $rmRemove ]] || return
	read -p "[$rmRemove] - Please confirm... " rm_confirm
	[[ "$rm_confirm" == "YES" ]] && rm "$rmRemove"
}

function youtube480 { [[ -n $1 ]] && youtube-dl -o "%(title)s" -i -f "bestvideo[height<=480]+bestaudio/best[height<=480]" $1; }

function newk {
	[[ -n $1 ]] || return
	st -e "$@" &
	disown
	}

function clean {
	[[ -n $1 ]] || return
	$@ &> /dev/null &
	disown
	}
