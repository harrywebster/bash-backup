
# Prerequisites

## Mac OSx

```
brew install rsnapshot rsync
```

## Docker

Download and install the `Docker CE` (cuminity edition) from
https://www.docker.com then follow the Docker installation process for you
workstation enviroment (Linux, Winodws or Mac OSx)

## Installation

## Docker Installation (Windows)

```
cd /path/to/bash_backup
git pull
docker build -t bash_backup:latest ./
docker run -h bash-backup --rm --mount type=bind,source="G:\,target=/backup/source" --mount type=bind,source="F:\,target=/backup/destination" bash_backup:latest
```

## Docker Installation (Linux or OSx)

```
cd /path/to/bash_backup
git pull
docker build -t bash_backup:latest ./
docker run \
	-h bash-backup \
	--rm \
	--mount type=bind,source=/Volume/DATA_TO_BACKUP,target=/backup/source \
	--mount type=bind,source=/Volume/BACKUPS,target=/backup/destination \
	bash_backup:latest
```

## Apple Mac OSx

After cloning this repo please change all the vaules that are relevant in `run.mac.sh`. You'll need to specify the install path of BASH-backup, the source location and destination.

```
ln -s ~/bash-backup/run.mac.sh ~/backup.sh /usr/local/bin/bash-backup
```
