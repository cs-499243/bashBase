#!/bin/bash

# Add to .bashrc or .bash_profile: 
#	bashBase="{location of easyAlias.sh}"; source "$easyLoc/easyAlias.sh"

export bashBase=$bashBase
alias ad="$bashBase/listerFix.sh -m manual"
alias ad_auto="$bashBase/listerFix.sh"
alias ad_series="$basBase/seriesSet.sh"
