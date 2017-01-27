#!/bin/bash

#This script backs-up and restores configuration for nemo from dconf
#takes two arguments,
#1 - the filepath for the backup file
#2 - 0 or 1 for backup or restore. 0 for backup and 1 for restore

nemo_bnr(){
    local backup_filename="$1"
    #backup settings
    if [ "$2" -eq 0 ]; then
	#dconf dump /org/nemo/ > "$backup_filename"
	local var=$(dconf dump /org/nemo/) #"$backup_filename"
	if ! [ -z "$var" ]; then
	    dconf dump /org/nemo/> "$backup_filename"
	    printf "Backing up settings for nemo...Done."
	    return 0
	else
	    printf "Backing up settings for nemo...Failed."
	    return 1
	fi
    #restore backup
    elif [ "$2" -eq 1 ]; then
	#dconf load /org/nemo/ < "$backup_filename"
	if dconf load /org/nemo/ 2>&1 /dev/null < "$backup_filename"; then
	    printf "Restoring settings for nemo...Done."
	    #set nemo as the default file manager
	    gsettings set org.gnome.desktop.background show-desktop-icons false
	    xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
	    return 0
	else
	    printf "Restoring settings for nemo...Failed."
	    return 1
	fi
    else
	printf "Invalid argument received."
	return 1
    fi
}

#sanity checks
if [ -z "$1" ] || [ -z "$2" ]; then
    printf "nemo-bnr.sh: Invalid arguments provided. Exiting."
    exit 1
fi

if ! type dconf &>> /dev/null; then
    printf "nemo-bnr.sh: dconf not present. Please install dconf before running this script."
    exit 1
fi

nemo_bnr "$1" "$2"
exit $?
