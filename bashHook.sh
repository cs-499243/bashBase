#!/bin/bash

# Add to .bashrc or .bash_profile:
#	export bashBase="LOCATION OF THIS FOLDER"; source "$bashBase/bashHook.sh"

function bashHook {
	echo -e "ad\t\t - listerFix"
	echo -e "hookedit\t - edit bashHook"
	echo -e "refresh\t\t - reload .bash_profile"

	echo -e "bashRelay\t - directly reference bashBase .sh files"
	echo -e "newk\t\t - open something in a new konsole"

	echo -e "q\t\t - Regex Query to run commands on searched items"
	echo -e "qrm\t\t - Regex Query specific for rm"
	echo -e "fls\t\t - Find with links"

	echo -e "youtube480\t - download videos at 480p"

	echo -e "crun\t\t - script compiling, running and sorting"
	echo -e "\t... -clean, java, cpp, as, go, groff"

}

# Give aliases to my most used programs
alias ad="$bashBase/listerFix/listerFix.sh"
alias hookedit="nano $bashBase/bashHook.sh"
alias refresh="source $HOME/.bash_profile"

source $bashBase/Misc/bashRelay.sh
source $bashBase/Misc/crun.sh
