#!/bin/bash

# DEFAULTS
adCommand="touch"
adInfo=false

adFiller=""
adIncFiller=""
adIncrement=0
adMode="automatic"


# FUNCTIONS
function commandAction {
	$adCommand "$adFiller$1" || echo "Invalid command"
	}

function giveInfo {
	echo -n "INFO - Executing '$adCommand' with '$adMode' mode, "
	echo -n "increment '$adIncrement', filler '$adFiller', "
	echo "increment filler '$adIncFiller'"
	}

function giveHelp {
	echo "-e|--echo --> Print to console instead of writing files"
	echo "-f|--filler [] --> Put a filler at the start of text (no space)"
	echo "-F|--spaced-filler [] --> Put a filler at the start of the text"
	echo "-h|--help --> Show this help screen"
	echo "-i|--increment # --> Repeat any process # times"
	echo "-if|--increment-filler [] --> Put a filler before the increment"
	echo "-m|--mode [] --> Set a mode to run the program (manual/automatic... Automatic is default"
	echo "-?|--info --> Prints to console what is going to be done"
	}

function modeManual {
	while :; do
		read -p " - " adInput
		
		if [ "$adInput" = "" ]; then break; fi

		if [ $adIncrement -eq 0 ]; then commandAction "$adInput"
		else
			for ((i=1; i<=$adIncrement; i++)) do
				commandAction "$adInput$adIncFiller$i"
			done
		fi
		
	done }

function modeAutomatic {
	if [ $adIncrement -eq 0 ]; then
		while [ $# -gt 0 ]; do
			commandAction "$1"; shift
		done
	else 
		while [ $# -gt 0 ]; do
			for ((i=1; i<=$adIncrement; i++)) do
				commandAction "$1$adIncFiller$i"
			done; shift
		done 
	fi }

# INPUT CONFIG
if [ $# -eq 0 ]; then
	echo "ERROR - No inputs given. Showing help screen"
	giveHelp
fi

while [ $# -gt 0 ]; do

	case $1 in
		-e|--echo)
			adCommand="echo"; shift; ;;

		-f|--filler)
			case $2 in
				-*)	echo "WARNING - No filler given. Defaulting" ;;
				*)	adFiller=$2; shift
			esac; shift; ;;

		-F|--spaced-filler)
			case $2 in
				-*)	echo "WARNING - No filler given. Defaulting";;
				*)  adFiller="$2 "; shift
			esac; shift; ;;

		-h|--help)
			giveHelp
			exit 0; ;;

		-i|--increment)
			if [[ $2 == -* ]]
				then echo "WARNING - No increment given. Defaulting"
			elif [[ $2 =~ ^[+-]?[0-9]+$ ]];
				then adIncrement=$2; shift
			else
				echo "ERROR - $2 is not a valid increment (integer)"; exit 0
			fi; shift; ;;
			
		-if|--increment-filler)
			case $2 in
				-*)	echo "WARNING - No filler given. Defaulting" ;;
				*)	adIncFiller=$2; shift
			esac; shift; ;;

		-m|--mode)
			case $2 in
				manual|automatic)	adMode=$2; shift ;;
				-*)					;;
				*)  				echo "ERROR - $2 is not a valid mode"; exit 0
			esac; shift; ;;

		-?|--info)
			adInfo=true; shift; ;;

		*)	break; ;;
			
	esac
done

# MAIN PROCESSING
if $adInfo; then giveInfo; fi
if [ $# -eq 0 ]; then echo "WARNING - No values given. Will blank out"; fi

case $adMode in
	manual) 	modeManual ;;
	automatic)	modeAutomatic "$@";;
esac

# TODO
# 1) Add support for leading zeroes - may require redoing the for loops
# 2) Allow an empty input to be given so it's just filler + increment
# 3) Clean up the code so anything can be customisable from outside
# 4) Fix up the help section
# 5) Read folder contents with while IFS= read -r line; do touch "$line"; done < 
