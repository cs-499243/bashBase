#!/bin/bash

# Add to .bashrc or .bash_profile:
#	export bashBase="LOCATION OF THIS FOLDER"; source "$bashBase/bashHook.sh"

# Function to allow you to do (e.g.) "bashRelay listerFix.sh" instead of writing "bash $bashBase/listerFix.sh"
function bashRelay {
	
	relayListing=$(find $bashBase -name "*.sh"); relayListing="${relayListing//$bashBase/}"
	
	if [[ -z $1 ]]
		then echo $relayListing; return
		else fileAction=$1; shift
	fi
	
	bash $bashBase/$fileAction $@ || echo -e " - FAILED\n$relayListing"
	}
	
function ad_auto {
	bashRelay listerFix/listerFix.sh $@
	}
	
function ad_series {
	bashRelay listerFix/listerFix_series.sh $@
	}



function youtube480 {
	[[ -n $1 ]] && youtube-dl -o "%(title)s" -f "bestvideo[height<=480]+bestaudio/best[height<=480]" $1
	}



function crun {
	[[ -n $1 || -n $2 ]] || return
	case $1 in
		java) 
			ExtFile="java"; ExtComp="class"
			ScrCom="javac $2.$ExtFile"
			ScrRun="java $2"
			;;
		cpp) 
			ExtFile="cpp"; ExtComp="out"
			ScrCom="g++ $2.$ExtFile -o $2.$ExtComp"
			ScrRun="./$2.$ExtComp"
			;;
		as)
			ExtFile="s"; ExtComp="out"
			ScrCom="gcc $2.$ExtFile -no-pie -o $2.$ExtComp"
			ScrRun="./$2.$ExtComp"
			;;
		go)
			ExtFile="go"; ExtComp="out"
			ScrCom="gccgo $2.$ExtFile -o $2.$ExtComp"
			ScrRun="./$2.$ExtComp"
			;;
		groff)
			ExtFile="ms"; ExtComp="ps"
			groff -ems $2.$ExtFile > $2.$ExtComp
			return
			;;
		*)
			return
			;;
	esac
	
	case $2 in
		-clean)
			ls *.$ExtComp || return; 
			read -p "YES to confirm? " YESTest
			[[ "$YESTest" == "YES" ]] && rm *.$ExtComp || echo " - Doing nothing"
			;;
		*)
			# if [[ ! -e $1.class || $1.class -ot $1.java ]]; then javac $1.java || return; fi
			if [[ ! -e $2.$ExtComp || $2.$ExtComp -ot $2.$ExtFile ]]; then $ScrCom || return; fi
			$ScrRun
			;;
	esac
	}



function newk {
	[[ -n $1 ]] || return
	konsole -e "$@" &
	}


# Give aliases to my most used programs
alias ad="$bashBase/listerFix/listerFix.sh -m manual"
alias hookedit="nano $bashBase/bashHook.sh"
alias refresh="source $HOME/.bash_profile"

alias bashHook="echo 'Methods: ad, hookedit, refresh, bashRelay, ad_auto, ad_series, refresh, youtube480, crun [java cpp as go groff] {-clean}, newk'"
