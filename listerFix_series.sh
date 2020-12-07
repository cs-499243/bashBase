#!/bin/bash

# $1=TITLE* $2=NUM* $3=FILLER $4=URL

function badParameters { 
	echo " - ERROR - $1${2:+ or $2}"
	echo "Correct parameters are ([TITLE]* [NUM]* [FILLER] [URL]) where * is required"
	exit 1
	}

[[ -d "$1" || -z $1 ]]	&& badParameters "TITLE" "folder exists"
[[ -z $2 ]]				&& badParameters "NUM"

# Make folder with series expanded inside - if filler is given, used
mkdir "$1"; cd "$1"
bash $bashBase/listerFix.sh -i $2${3:+ -f $3} ""

# If URL is given, make link file
[[ -n $4 ]] && echo -e "[Desktop Entry]\nIcon=text-html\nType=Link\nURL[\$e]=$4" > _LINK

# Return - not essential but clean
cd -

# TODO
# Add in a loop to allow for all parameters in standard way
# Allow for a forced override of exit conditions
