#!/bin/bash


# color

red="\033[31m"
black="\033[0m"

function LogError {

timenow=$(date +%H.%M.%S)

echo -e "$red[$timenow] Error: $*$black"
}

function LogInfo {
timenow=$(date +%H.%M.%S)

echo -e "[$timenow] Info: $*"
}


