#!/bin/bash

## Please configure the following!

install_path=/Users/harry/bash-backup
files_to_backup=/Users/harry/Dropbox/Invoices
backup_location=/Users/harry/Desktop/backup

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
