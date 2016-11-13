#!/bin/bash

. /usr/lib/docker-shell-scripts-lib/get-id.sh


function tag-image {

back=""
# check if we get a username
if [ -z "$1" ]; then
	back="Error: Not enough arguments"
else
	patternrep=$1
	patterntag="new"
	# get the id from the new image
	newid=$(get-id-from-name $patternrep $patterntag)
		case $newid in
		 "Error*")
			echo "Error: Cloud not get the id from the new image"
			echo "$newid"
			back="error"
		;;
		 "nothing")
			echo "Error there is no image with the tag new"
			back="error"
		;;
		*)
			# get the id from the image of today when it exist
			date=$(date +%Y-%m-%d)
        		patterntag="$date"
			todayid=$(get-id-from-name $patternrep $patterntag)
			case $todayid in
			"Error*")
				echo "Error: Cloud not get the id from the new image"
                		echo "$newid"
                		back="error"
			;;
			"nothing")
				# there is no image from today
				##### check is there an image with  this tag?
				patterntag="latest"
				if [ ! $(get-id-from-name $patternrep $patterntag) = "nothing" ];then
				docker rmi "$patternrep:latest"
				fi
                		# tag the new immage with the date from today and latest
                		docker tag "$newid" "$patternrep:latest"
                		docker tag "$newid" "$patternrep:$date"
                		# rmi the tag new
                		docker rmi "$patternrep:new"
			;;
			*)
				# there is an image from today
				# ## check is there an image with this tag
				if [ ! $(get-id-from-name $patternrep $patterntag) = "nothing" ];then
                                docker rmi "$patternrep:latest"
                                fi
				docker rmi "$patternrep:$date"
				# tag the new immage with the date from today and latest
				docker tag "$newid" "$patternrep:latest"
				docker tag "$newid" "$patternrep:$date"
				# rmi the tag new
				docker rmi "$patternrep:new"
			;;
			esac
		esac
fi
echo $back

}


