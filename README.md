# bashBase
Bash programs that I use and find convenient

## consoleNet / newsboatConfig [IN DEV]
- Generally adds in the settings I use
- Sets macros to use newsboatInterface.sh with various settings

## consoleNet / newsboatInterface.sh [IN DEV]
- [grep, sed, tail, "vlc", youtube-dl]
- Interface to download and manage files related to RSS feeds
- Currently just allows you to download, open and move a youtube video from newsboat

## consoleNet / youtubeFeeder.sh [IN DEV]
- [cut, expr, "$IFS", rev, shift, youtube-dl] ??
- Allows you to take a youtube playlist and convert it to an RSS file
- Needs an addon to allow for continued updating

## / bashHook.sh
- [alias, export, bash, rm, ls] ??
- Simple script that links to .bash_profile to make things quicker/easier
- [groff, java, g++, gcc, gccgo] "crun": Easily compile, run and clean code
- "youtube480": Download videos from youtube in my preferred format
- "bashRelay": Allows you to run bashBase code easier
- "newk": Open a new console for a given command
- "refresh": Resource the current console

## listerFix / listerFix.sh [IN DEV]
- [shift, "touch"] ??
- A rewrite of a python script I made to easily make files based a given formatting
- You can feed in a list of file names and it will auto create them X number of times with a certain name structure
- Currently being generalised to a "do anything X times in this way" program
- Will be linked to another script down the line that will add info to certain files and give them use

## listerFix / listerFix_series.sh
- [bash]
- listerFix addon to quickly make "series" folders with a URL link
