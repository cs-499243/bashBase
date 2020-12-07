# $1 is the title
# $2 is the url
# $3 is the number of videos
# $4 is the filler for each item - Do not include " - "
echo "1 title, 2 url, 3 num, 4 filler"
if [ ! $# -eq 0 ]; then
	mkdir "$1"; cd "$1"
	echo "[Desktop Entry]" > "_URL"
	echo "Icon=text-html" >> "_URL"
	echo "Type=Link" >> "_URL"
	echo "URL[\$e]=$2" >> "_URL"
	bash $bashBase/listerFix.sh -i $3 -f "$4 - " -m automatic ""
fi
