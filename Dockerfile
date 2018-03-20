FROM ubuntu:16.04 AS bash_backup

RUN apt-get update
RUN apt-get install -y openssh-server rsnapshot rsync

RUN ["mkdir", "/backup"]

COPY backup.sh /backup/backup.sh
COPY rsnapshot.conf /backup/rsnapshot.conf

ENTRYPOINT /backup/backup.sh
