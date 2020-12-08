if [ "$(grep -s -A 1 $1 ~/.newsboat/YoutubeTitle.txt | tail -1)" == "" ]; then
	echo $1 >> ~/.newsboat/YoutubeTitle.txt
	youtube-dl --get-filename -o '~/Videos/%(title)s' -f 'bestvideo[height<=480]+bestaudio/best[height<=480]' $1 >> ~/.newsboat/YoutubeTitle.txt
fi

youtube-dl -q -o '~/Videos/%(title)s' -f 'bestvideo[height<=480]+bestaudio/best[height<=480]' $1 &
