#!/bin/bash

# function to get an id for an image from the name and the tag
# returns
# "nothing" when the image was not found
# "the id of the image" when we get the id
# "Error: *" on error
function get-id-from-name {

# set the return value to nothing
back="nothing"
shopt -s extglob
if [ -z $1 ] || [ -z $2 ] ; then
	back="Error: not enough arguments"
else
	patternrep=$1
	patterntag=$2
	linenumber=2
	docker images > /tmp/images-docker.txt
	if [ ! $? = 0 ] ; then
		back="Error: Colud not get the full list of all images. Command 'docker images' failes"
	else
		linequantity=$(sed $= -n /tmp/images-docker.txt)
		while [[ $linequantity != $linenumber ]]
		do
			cline=$(sed -n "${linenumber} p" /tmp/images-docker.txt)
			cline=${cline//+(  )/;}
			cline=${cline%;}
			#echo $cline
			if [[ "$cline" = *"$patternrep"* && "$cline" = *"$patterntag"* ]] ; then
				cline=${cline%;*}
				cline=${cline%;*}
				cline=${cline#*;}
				cline=${cline#*;}
				back="$cline"
				break
			fi
			linenumber=$(( linenumber + 1 ))
			#echo $linequantity
			#echo $linenumber
		done
	fi
fi
echo $back

}

#repo="jonatanschlag/honeyssh-base2"
#tag="latest"
#return=$(get-id-from-name $repo)
#echo "$return"
