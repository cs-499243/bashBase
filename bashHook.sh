#!/bin/bash

# Add to .bashrc or .bash_profile: 
#	export bashBase="LOCATION OF THIS FOLDER"; source $bashBase/bashHook.sh

# Function to allow you to do (e.g.) "bashRelay listerFix.sh" instead of writing "bash $bashBase/listerFix.sh"
function bashRelay {
	# If a program name is given, try to open it. If not, list programs
	if [[ -n $1 ]]; then bash $bashBase/$1; else ls $bashBase; fi
	}

# Export ~ as a specific variable - allows you to use ~ in ls and things like it
export baseLoc=~
# Give aliases to my most used programs
alias ad="$bashBase/listerFix.sh -m manual"
alias ad_series="$bashBase/listerFix_series.sh"
