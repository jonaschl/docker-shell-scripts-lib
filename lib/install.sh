#!/bin/bash
. /usr/lib/docker-shell-scripts-lib/logging.sh

function InstallSystemdUnitFile {

if [ -z $1 ]; then
LogError "Need path to file"
fi
path="$1"
name=${var##"*/"}
LogInfo "Install Systemd file $name into /etc/systemd/system/"
cp -f "$path" "/etc/systemd/system/$name"
systemctl daemon-reload

}
