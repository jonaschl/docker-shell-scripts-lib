#!/bin/bash

. /usr/lib/docker-shell-scripts-lib/logging.sh

function CheckForFile {

if [ -z $1 ]; then
LogError "Need path to file"
fi

file="$1"

if [ ! -f "$file" ]; then
LogError "No such file: $file"
exit 1
fi

}
