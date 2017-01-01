#!/bin/bash

#This script backs-up and restores configuration for liferea from dconf
#takes two arguments,
#1 - the filepath for the backup file
#2 - 0 or 1 for backup or restore. 0 for backup and 1 for restore

liferea_bnr(){
    local backup_filename="$1"
    #backup settings
    if [ "$2" -eq 0 ]; then
	#dconf dump /org/gnome/liferea/ > "$backup_filename"
	local var=$(dconf dump /org/gnome/liferea/) # "$backup_filename"
	if ! [ -z "$var" ]; then
	    dconf dump /org/gnome/liferea/> "$backup_filename"
	    msg=$(printf "Backing up settings for liferea...Done.")
	    log_error 0 "$msg"
	    return 0
	else
	    msg=$(printf "Backing up settings for liferea...Failed.")
	    log_error 1 "$msg"
	    return 1
	fi
    #restore backup
    elif [ "$2" -eq 1 ]; then
	#dconf load /org/gnome/liferea/ < "$backup_filename"
	if dconf load /org/gnome/liferea/ &>> /dev/null < "$backup_filename"; then
	    msg=$(printf "Restoring settings for liferea...Done.")
	    log_error 0 "$msg"
	    return 0
	else
	    msg=$(printf "Restoring settings for liferea...Failed.")
	    log_error 1 "$msg"
	    return 1
	fi
    else
	msg=$(printf "Invalid argument received.")
	log_error 1 "$msg"
	return 1
    fi
}

if ! source "../helper scripts/logger.sh"; then
    printf "ERROR: Logger script not found/failed load. Exiting.\n"
    exit 1
fi

#sanity checks
if [ -z "$1" ] || [ -z "$2" ]; then
    msg=$(printf "liferea-bnr.sh: Invalid arguments provided. Exiting.")
    log_error 1 "$msg"
    exit 1
fi

if ! type dconf &>> /dev/null; then
    msg=$(printf "liferea-bnr.sh: dconf not present. Please install dconf before running this script.")
    log_error 1 "$msg"
    exit 1
fi

liferea_bnr "$1" "$2"
exit $?
