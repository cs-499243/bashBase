#!/bin/bash

# Add to .bashrc or .bash_profile: 
#	bashBase="{location of easyAlias.sh}"; source "$easyLoc/easyAlias.sh"

export bashBase=$bashBase
alias ad="$bashBase/listerFix.sh -m manual"
alias AD="$bashBase/listerFix.sh"

