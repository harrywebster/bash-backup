FROM ubuntu:16.04 AS bash_backup

RUN apt-get update
RUN apt-get install -y rsnapshot rsync gnupg2

RUN ["mkdir", "/backup"]

COPY src/backup.sh /backup/backup.sh
COPY src/rsnapshot.conf /backup/rsnapshot.conf

# Pass over encryption private key if defined
RM /backup/private.key
COPY private.key /backup/private.key

RUN ["chmod", "755", "/backup/backup.sh"]

ENTRYPOINT /backup/backup.sh
