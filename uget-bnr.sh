#!/bin/bash

#This script downloads and copies uGet's ambiance and radiance indicator icons. By default is ambiance.
#Please see http://ugetdm.com/blog/3-stable/19-tray-icons-quick-fix-for-ubuntu-ambiance-a-radiance and https://imgur.com/a/UbtBn

URL=https://cytranet.dl.sourceforge.net/project/urlget/uget%20%28stable%29/1.10.3/tray-icon-quick-fix-1.10.3.tar.gz
FILE_NAME=tray-icon-quick-fix-1.10.3.tar.gz
#set to 0 for radiance
AMBIANCE=1
FILE_NAME=tray-icon-quick-fix-1.10.3.tar.gz
DIR_NAME="uget-ambiance-radiance-tray-icons"
SOURCE_REL_DIR=""
TARGET_DIR="/usr/share/icons/hicolor/22x22/apps"

#if a backup was requested
if [ "$2" -eq 1 ]; then
    if [ "$AMBIANCE" -eq 1 ]; then
	SOURCE_REL_DIR="/ambiance/"
    else
	SOURCE_REL_DIR="/radiance/"
    fi

    #Download, extract and copy the icons
    wget "$URL" && if ! [ -d "$DIR_NAME" ]; then\
			  mkdir "$DIR_NAME";\
	fi && tar -xf "$FILE_NAME" -C "$DIR_NAME" && sudo cp "$DIR_NAME""$SOURCE_REL_DIR"*.png "$TARGET_DIR" && exit 0
    exit 1
else
    exit 0
fi

exit 1
