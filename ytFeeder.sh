echo $1

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
