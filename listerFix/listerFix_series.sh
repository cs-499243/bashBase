#!/bin/bash

# $1=TITLE* $2=NUM* $3=FILLER $4=URL

# Function that runs when parameters fail
function badParameters { 
	# Print the invalid parameter + extra info if given
	echo " - ERROR - $1${2:+ or $2}"
	echo "Correct parameters are ([TITLE]* [NUM]* [FILLER] [URL]) where * is required"
	exit 1
	}

# Test if given "title" folder already exists and if "title" is actually given
[[ -d "$1" || -z $1 ]]	&& badParameters "TITLE" "folder exists"
[[ -z $2 ]]				&& badParameters "NUM"

mkdir "$1"; cd "$1"
# Run listerFix for "num" given and "filler", if given
bash $bashBase/listerFix/listerFix.sh -i $2${3:+ -f "$3"} ""

# Make a url file if the "URL" is given
[[ -n $4 ]] && echo -e "[Desktop Entry]\nIcon=text-html\nType=Link\nURL[\$e]=$4" > _LINK

# Return - not essential but clean
cd -

# TODO
# Add in a loop to allow for all parameters in standard way
# Allow for a forced override of exit conditions
