# bashBase
Bash programs that I use and find convenient

## newsboat / config
- Generally adds in the settings I use
- Sets macros to use newsboatInterface.sh with various settings

## newsboat / newsboatInterface.sh
- [grep, sed, tail, "vlc", youtube-dl]
- Interface to download and manage files related to RSS feeds
- Currently just allows you to download, open and move a youtube video from newsboat

## newsboat / youtubeFeeder.sh
- [cut, expr, "$IFS", rev, shift, youtube-dl]
- Allows you to take a youtube playlist and convert it to an RSS file
- Needs an addon to allow for continued updating

## newsboat / youtubeFeeder_refresh.sh
- [bash, cut, head, rev, shift, tail]
- Not entirel useful but allows you to mass refresh files. More useful to directly refresh each with youtubeFeeder, however

## / bashHook.sh
- [alias, export, bash]
- Simple script that links to .bash_profile to make things quicker/easier

## / listerFix.sh
- [shift, "touch"]
- A rewrite of a python script I made to easily make files based a given formatting
- You can feed in a list of file names and it will auto create them X number of times with a certain name structure
- Currently being generalised to a "do anything X times in this way" program
- Will be linked to another script down the line that will add info to certain files and give them use

## / listerFix_series.sh
- [bash]
- listerFix addon to quickly make "series" folders with a URL link

## / manageJournal.sh
- [cut, date, grep, head, "nano", sed, stat, tail, tr, wc, xargs]
- Very in dev - very very unstable - very very not great
- Allows you to add in timestamps and manage a journal relatively easily
