#!/bin/bash

# Add to .bashrc or .bash_profile: 
#	export bashBase="LOCATION OF THIS FOLDER"; source $bashBase/bashHook.sh

function bashRelay {
	if [[ -n $1 ]]; then bash $bashBase/$1; else ls $bashBase; fi
	}

export baseLoc=~
alias ad="$bashBase/listerFix.sh -m manual"
alias ad_series="$bashBase/listerFix_series.sh"
