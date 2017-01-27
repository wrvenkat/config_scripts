#!/bin/bash

#This script backs-up and restores configuration for unity from dconf
#takes two arguments,
#1 - the filepath for the backup file
#2 - 0 or 1 for backup or restore. 0 for backup and 1 for restore

unity_bnr(){
    local backup_filename="$1"
    #backup settings
    if [ "$2" -eq 0 ]; then
	#dconf dump /com/canonical/unity/ > "$backup_filename"
	local var=$(dconf dump /com/canonical/unity/)> "$backup_filename"
	if ! [ -z "$var" ]; then
	    dconf dump /com/canonical/unity/ > "$backup_filename"
	    printf "Backing up settings for unity...Done."
	    return 0
	else
	    printf "Backing up settings for unity...Failed."
	    return 1
	fi
    #restore backup
    elif [ "$2" -eq 1 ]; then
	#dconf load /org/gnome/unity/ < "$backup_filename"	
	if dconf load /com/canonical/unity/ 2>&1 < "$backup_filename"; then
	    printf "Restoring settings for unity...Done."
	    return 0
	else
	    printf "Restoring settings for unity...Failed."
	    return 1
	fi
    else
	printf "Invalid argument received."
	return 1
    fi
}

#sanity checks
if [ -z "$1" ] || [ -z "$2" ]; then
    printf "unity-bnr.sh: Invalid arguments provided. Exiting."
    exit 1
fi

if type dconf &>> /dev/null; then
    :
else
    printf "unity-bnr.sh: dconf not present. Please install dconf before running this script."
    exit 1
fi

unity_bnr "$1" "$2"
exit $?
