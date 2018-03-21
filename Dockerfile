FROM ubuntu:16.04 AS bash_backup

RUN apt-get update
RUN apt-get install -y rsnapshot rsync openssl

RUN ["mkdir", "/backup"]

COPY src/backup.sh /backup/backup.sh
COPY src/rsnapshot.conf /backup/rsnapshot.conf

RUN ["chmod", "755", "/backup/backup.sh"]

# By default disable encryption.
RUN ["rm", "-rf", "/backup/password.txt"]
RUN ["rm", "-rf", "/backup/restore.txt"]

# Uncomment below to enable PGP encryption
COPY password.txt /backup/password.txt
COPY restore.txt /backup/restore.txt

ENTRYPOINT /backup/backup.sh
