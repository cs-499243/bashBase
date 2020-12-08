vidTitle="$(grep -A 1 $1 ~/.newsboat/YoutubeTitle.txt | tail -1)"

#vidExist=$(ls "$vidTitle"*) && rm "$vidExist"

#grep -v "$vidTitle" ~/.newsboat/YoutubeTitle.txt #> ~/.newsboat/YoutubeTitle.txt
#grep -v "$1" ~/.newsboat/YoutubeTitle.txt > ~/.newsboat/YoutubeTitle.txt
