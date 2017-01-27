#!/bin/bash

#This script backs-up and restores configuration for encfs from dconf
#takes two arguments,
#1 - the filepath for the backup file
#2 - 0 or 1 for backup or restore. 0 for backup and 1 for restore

encfs_bnr(){
    local backup_filename="$1"
    #backup settings
    if [ "$2" -eq 0 ]; then
	#dconf dump /com/libertyzero/ > "$backup_filename"
	local var=$(dconf dump /com/libertyzero/) # "$backup_filename"
	if ! [ -z "$var" ]; then
	    dconf dump /com/libertyzero/ > "$backup_filename"
	    printf "Backing up settings for encfs...Done."
	else
	    printf "Backing up settings for encfs...Failed."
	    return 1
	fi
    #restore backup
    elif [ "$2" -eq 1 ]; then
	#dconf load /com/libertyzero/ < "$backup_filename"	
	if dconf load /com/libertyzero/ &>> /dev/null < "$backup_filename"; then
	    printf "Restoring settings for encfs...Done."
	else
	    printf "Restoring settings for encfs...Failed."
	    return 1
	fi
    else
	printf "Invalid argument received."
	return 1
    fi
    return 0
}

#sanity checks
if [ -z "$1" ] || [ -z "$2" ]; then
    printf "encfs-bnr.sh: Invalid arguments provided. Exiting."
    exit 1
fi

if ! type dconf &>> /dev/null; then
    printf "encfs-bnr.sh: dconf not present. Please install dconf before running this script."
    exit 1
fi

encfs_bnr "$1" "$2"
exit $?
