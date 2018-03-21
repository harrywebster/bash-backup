#!/bin/bash

# Detect if the backup store is encrypted
if [ -f /backup/password.txt ]; then
	if [ -f /backup/destination/encrypted-latest.dat ]; then
		openssl enc -aes-256-cbc -d -in /backup/destination/encrypted-latest.dat > /backup/destination/encrypted-latest.tar -pass file:/backup/password.txt
		openssl enc -aes-256-cbc -d -in /backup/destination/encrypted-snapshots.dat > /backup/destination/encrypted-snapshots.tar -pass file:/backup/password.txt

		tar -xvf /backup/destination/encrypted-latest.tar
		tar -xvf /backup/destination/encrypted-snapshots.tar

		rm -rf /backup/destination/encrypted-latest.dat /backup/destination/encrypted-latest.tar
		rm -rf /backup/destination/encrypted-snapshots.dat /backup/destination/encrypted-snapshots.tar
	fi
fi

echo `date '+%Y-%m-%d %H:%M:%S'` : Starting to mirror contents of source
echo
rsync -avzu --delete --stats /backup/source /backup/destination/latest/
echo
echo `date '+%Y-%m-%d %H:%M:%S'` : Finish mirroring

echo `date '+%Y-%m-%d %H:%M:%S'` : Starting snapshot saving differences
rsnapshot -c /backup/rsnapshot.conf daily
echo `date '+%Y-%m-%d %H:%M:%S'` : Finished snapshot

echo `date '+%Y-%m-%d %H:%M:%S'` : Fetch snapshot report
echo
rsnapshot -c /backup/rsnapshot.conf du
echo
echo `date '+%Y-%m-%d %H:%M:%S'` : Finished backup

# If the encryption key is found then encrypt the backup location before
# finishing up.
if [ -f /backup/password.txt ]; then
	if [ ! -f /backup/restore.txt ]; then
		if [ ! -f /backup/destination/encrypted-latest.dat ]; then
			# Compress the latest and snaphost directory into a single tar file for
			# encryption.
			tar -cf /backup/destination/encrypted-latest.tar /backup/destination/latest
			tar -cf /backup/destination/encrypted-snapshots.tar /backup/destination/snapshots

			openssl enc -aes-256-cbc -in /backup/destination/encrypted-latest.tar -out /backup/destination/encrypted-latest.dat -pass file:/backup/password.txt
			openssl enc -aes-256-cbc -in /backup/destination/encrypted-snapshots.tar -out /backup/destination/encrypted-snapshots.dat -pass file:/backup/password.txt

			rm -rf /backup/destination/latest /backup/destination/encrypted-latest.tar
			rm -rf /backup/destination/snapshots /backup/destination/encrypted-snapshots.tar
		fi
	fi
fi
