#!/bin/bash

## Please configure the following!

install_path=/path/to/bash_backup_cloned_from_github
files_to_backup=/path_to_the_files_youd_like_to_back_up
backup_location=/path_to_the_location_where_the_backup_will_be_stored

## DON'T EDIT BELOW THIS LINE

cd $install_path

git pull
docker build -t bash_backup:latest ./
docker run \
	--rm \
	--mount type=bind,source=$files_to_backup,target=/backup/source \
	--mount type=bind,source=$backup_location,target=/backup/destination \
	bash_backup:latest

osascript -e 'display notification "Your backup run is now complete - for details please refer to the terminal session." with title "BASH-backup"'
