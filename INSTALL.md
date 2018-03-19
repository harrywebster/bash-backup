
## Prerequisites

```
brew install rsnapshot rsync
```


## Installation

After cloning this repo please change all the vaules that are relevant in `~/config.json` then correct permissions and symbolic link to the /usr/local/bin directory.

```
chmod 755 ~/backup.sh
sudo ln -s ~/backup.sh /usr/local/bin/bash-backup
```

