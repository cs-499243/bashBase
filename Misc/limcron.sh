saveLoc=$bashBase/Misc/limcron.save
touch $saveLoc


function changeItem {
	# $1 = Setting $2 = timeslot $3 = command
	timeslot=$(date -d '$2' +"%s")
	
	
	result=$(cat $timeslot "," 
	
	echo $result >> $saveLoc
}


function run {
	# $1 = Sleep time (m)
	while :; do
		sleep $1m
		# Check items
	done
}

case $1 in 
	add)
		;;
	delete)
		;;
	list)
		;;
	run)
		run $2
		;;
	*)
		;;
