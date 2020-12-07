vidTitle="$(grep -A 1 $1 ~/.newsboat/YoutubeTitle.txt | tail -1)"

vidExist=$(ls "$vidTitle".*) && vlc "$vidExist" 2> /dev/null &
