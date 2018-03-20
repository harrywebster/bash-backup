FROM ubuntu:16.04 AS bash_backup

RUN apt-get update
RUN apt-get install -y openssh-server rsnapshot rsync

RUN ["mkdir", "/backup"]

COPY src/backup.sh /backup/backup.sh
COPY src/rsnapshot.conf /backup/rsnapshot.conf

RUN ["chmod", "755", "/backup/backup.sh"]

ENTRYPOINT /backup/backup.sh
