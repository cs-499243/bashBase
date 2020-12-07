# https://superuser.com/questions/1341684/youtube-dl-how-download-only-the-playlist-not-the-files-therein

cleanList=$(youtube-dl -j --flat-playlist $1 | cut -c109- | rev | cut -c43- | rev)

OLDIFS=$IFS; IFS=$'\n'

cleanTitles=($(echo "$cleanList" | cut -c11- | rev | cut -c24- | rev))
cleanURLS=($(echo "$cleanList" | rev | cut -c2-12 | rev))

IFS=$OLDIFS

for ((i=0 ; i<${#cleanTitles[@]} ; i++)); do
	itemTitle="${cleanTitles[i]}"
	itemURL="${cleanURLS[i]}"
	itemURLfull="https://www.youtube.com/watch?v=$itemURL"
	
	echo -e "$itemTitle - $itemURLfull"
	
	echo -e "[Desktop Entry]\nIcon=text-html\nType=Link\nURL[\$e]=$itemURLfull" > "$itemTitle"
done

: '
case $1 in
	*.zip)
		# $1 = NAME, $2 = VIDEO
		unzip $1
		locName=$(echo "$1" | cut -f 1 -d '.')
		echo $locName
		youtube-dl --load-info-json "$locName/$2"
		rm "$locName/$2"
		;;
	http*)
		## $1 = URL, $2 = NAME
		newName="$2"
		mkdir $newName
		cd $newName
		youtube-dl --skip-download --write-info-json --output "%(title)s" "$1"
		ls > ../$newName.txt
		cd ..
		zip -r -9 $newName.zip $newName
		rm -r $newName
		exit 0;;
esac
'

# TODO
# - Get rid of the old code (replace it with something better)
# - Arrange the new data in a useable form
# - Make sure it allows for higher length videos (will mess up the cutting of cleanList)
