#!/bin/bash
ROOT_UID="0"

#Check if run as root
if [ "$UID" -ne "$ROOT_UID" ] ; then
        echo "You must be root to do that!"
        exit 1
fi

snap list | awk -F" " '{if ($1 && NR>1) { system("snap refresh " $1 " 2>/dev/null") }}'

