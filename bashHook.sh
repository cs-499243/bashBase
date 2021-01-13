#!/bin/bash

# Add to .bashrc or .bash_profile: 
#	export bashBase="LOCATION OF THIS FOLDER"; source "$bashBase/bashHook.sh"

# Function to allow you to do (e.g.) "bashRelay listerFix.sh" instead of writing "bash $bashBase/listerFix.sh"
function bashRelay {
	# If a program name is given, try to open it. If not, list programs
	if [[ -n $1 ]]; then bash $bashBase/$1; else ls $(ls -d */); fi
	}

# Give aliases to my most used programs
alias ad="$bashBase/listerFix/listerFix.sh -m manual"
alias ad_auto="$bashBase/listerFix/listerFix.sh"
alias ad_series="$bashBase/listerFix/listerFix_series.sh"
alias refresh="source $HOME/.bash_profile"

alias bashHook="echo 'Methods: bashRelay, ad, ad_auto, ad_series, refresh'"
