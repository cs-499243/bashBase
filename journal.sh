#!/bin/bash
journalBase=$1 # Location of the journal

curYear=$(date +"%Y"); curDate=$(date +"%y-%m-%d"); curTime=$(date +"%H:%M")

focusFolder=$journalBase/$curYear; [ -d $focusFolder ] || mkdir $focusFolder
focusFile=$focusFolder/$curDate; [ -f $focusFile* ] || touch $focusFile.md
focusFile=$focusFolder/$(ls $focusFolder | grep $curDate)

focusTitle=$(head -n 1 $focusFile | tr '[:upper:]' '[:lower:]' | cut -c3- | sed 's/ /-/g')
focusFileApt=$focusFolder/$curDate-$focusTitle.md
[ "$focusFile" = "$focusFileApt" ] || mv $focusFile $focusFileApt; focusFile=$focusFileApt

[ -z "$(tail -n 1 $focusFile)" ] || echo -e -n "\n" >> $focusFile

[ -z "$(grep -e "^\[[0-9][0-9]\:[0-9][0-9]\]" $focusFile)" ] && echo "[$curTime] - " >> $focusFile
focusAge=$(expr $(date +%s) - $(stat -c %Y $focusFile))
[ $focusAge -gt 600 ] && echo "[$curTime] - " >> $focusFile

echo "$focusFile ... Age $focusAge"

nano -l -L +"$(wc -l < $focusFile | xargs expr 1 +)" $focusFile
