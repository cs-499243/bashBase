function crun {
	[[ -n $1 || -n $2 ]] || return
	case $1 in
		java)
			ExtFile="java"; ExtComp="class"
			ScrCom="javac $2.$ExtFile"
			ScrRun="java $2"
			;;
		cpp)
			ExtFile="cpp"; ExtComp="out"
			ScrCom="g++ $2.$ExtFile -o $2.$ExtComp"
			ScrRun="./$2.$ExtComp"
			;;
		as)
			ExtFile="s"; ExtComp="out"
			ScrCom="gcc $2.$ExtFile -no-pie -o $2.$ExtComp"
			ScrRun="./$2.$ExtComp"
			;;
		go)
			ExtFile="go"; ExtComp="out"
			ScrCom="gccgo $2.$ExtFile -o $2.$ExtComp"
			ScrRun="./$2.$ExtComp"
			;;
		groff)
			ExtFile="ms"; ExtComp="ps"
			groff -ems "$2.$ExtFile" > "$2.$ExtComp"
			return
			;;
		*)
			return
			;;
	esac
	case $2 in
		-clean)
			ls *.$ExtComp || return;
			read -p "YES to confirm? " YESTest
			[[ "$YESTest" == "YES" ]] && rm *.$ExtComp || echo " - Doing nothing"
			;;
		*)
			# if [[ ! -e $1.class || $1.class -ot $1.java ]]; then javac $1.java || return; fi
			if [[ ! -e $2.$ExtComp || $2.$ExtComp -ot $2.$ExtFile ]]; then $ScrCom || return; fi
			$ScrRun
			;;
	esac; }
