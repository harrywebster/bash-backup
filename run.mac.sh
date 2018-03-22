#!/bin/bash

## Please configure the following!

install_path=/path/to/bash_backup_cloned_from_github
files_to_backup=/path_to_the_files_youd_like_to_back_up
backup_location=/path_to_the_location_where_the_backup_will_be_stored
snapshot_only=false

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
	--env SNAPSHOT_ONLY=$snapshot_only \
	--mount type=bind,source=$files_to_backup,target=/backup/source \
	--mount type=bind,source=$backup_location,target=/backup/destination \
	bash_backup:latest

osascript -e 'display notification "Your backup run is now complete - for details please refer to the terminal session." with title "BASH-backup"'
