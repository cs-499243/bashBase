# e.g. listerFix --command touch -0 test -1 #0-5 -2 done "0-1-2"
#  test-1-done test-2-done test-3-done test-4-done test-5-done

# --command - simply set a variable defining the action
# -# - Go to a function and process the setting - return and add to an array
# At the end, take the format and sub in the array equivalents
# Then send to the action function to process it

#DEFAULTS
giveInfo=0
numSettings=()
outCommand="touch"
outStructure=""

function numProcess {
	# $1 = Value to use - may be string or #NUM-NUM
	echo "Value"
	}
	
function outAction {
	# $1 = outCommand, $2 = outStructure, $@ = numSettings
	:
	}

 
while [ $# -gt 1 ]; do
case $1 in
	--command) 
		shift
		if [[ $1 != -* ]] && [[ -n $1 ]]
		then
			outCommand="$2"
			shift
		fi; ;;

	--echo)
		shift
		outCommand="echo"
		;;
	
	-[0-9]) 
		shift
		if [[ $1 != -* ]] && [[ -n $1 ]]
		then
			numSettings+=("$(numProcess $1)")
			shift
		fi; ;;

	*) break; ;;
esac
done

# Now allow for the actual values

# Structure value: could be "01...23", "manual", "file" or "help"
$outStructure="$1"
