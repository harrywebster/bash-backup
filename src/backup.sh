#!/bin/bash

# Detect if the backup store is encrypted
if [ -f /backup/destination/encrypted ]; then
	// decrypt destination here...
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
if [ -f /backup/private.key ]; then
	// encrypt destination here...
	tar -cf /backup/destination/encrypted-latest.tar /backup/destination/latest
	tar -cf /backup/destination/encrypted-snapshots.tar /backup/destination/snapshots
	rm -rf /backup/destination/latest
	rm -rf /backup/destination/snapshots
fi
