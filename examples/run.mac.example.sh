#!/bin/bash

## Please configure the following!

install_path=/Users/harry/bash-backup
files_to_backup=/Users/harry/Dropbox/Invoices
backup_location=/Users/harry/Desktop/backup

## DON'T EDIT BELOW THIS LINE

if [ ! -f "$install_path/README.md" ]; then
	echo I dont think youve specified the correct install_path, please check and try again.
	exit
fi

if [ ! -d "$files_to_backup" ]; then
	echo The source \(files to backup\) directory cannot be found - $files_to_backup
	exit
fi

if [ ! -d "$backup_location" ]; then
	echo The backup destination directory cannot be found - $backup_location
	exit
fi

cd $install_path

git pull
docker build -t bash_backup:latest ./
docker run \
	--rm \
	--mount type=bind,source=$files_to_backup,target=/backup/source \
	--mount type=bind,source=$backup_location,target=/backup/destination \
	bash_backup:latest

osascript -e 'display notification "Your backup run is now complete - for details please refer to the terminal session." with title "BASH-backup"'
