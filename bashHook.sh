#!/bin/bash

# Add to .bashrc or .bash_profile:
#	export bashBase="LOCATION OF THIS FOLDER"; source "$bashBase/bashHook.sh"

function bashHook {
	echo -e "ad\t\t - listerFix manual mode"
	echo -e "hookedit\t - edit bashHook"
	echo -e "refresh\t\t - reload .bash_profile"
	
	echo -e "bashRelay\t - directly reference bashBase .sh files"
	echo -e "ad_auto\t\t - listerFix automatic mode"
	echo -e "ad_series\t - listerFix addon to support series"
	echo -e "newk\t\t - open something in a new konsole"

	echo -e "youtube480\t - download videos at 480p"
	
	echo -e "crun\t\t - script compiling, running and sorting"
	echo -e "\t... -clean, java, cpp, as, go, groff"
	
}

# Give aliases to my most used programs
alias ad="$bashBase/listerFix/listerFix.sh -m manual"
alias hookedit="nano $bashBase/bashHook.sh"
alias refresh="source $HOME/.bash_profile"

source $bashBase/Misc/bashRelay.sh
source $bashBase/Misc/crun.sh
