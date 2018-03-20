# bash-backup
A collection of open source backup tools brought together to help users backup from one location to another.

## Running

```bash
cd /path/to/bash_backup
git pull
docker build -t bash_backup:latest ./
docker run -h bash-backup --rm --mount type=bind,source="G:\,target=/backup/source" --mount type=bind,source="F:\,target=/backup/destination" bash_backup:latest
```
