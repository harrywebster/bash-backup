#!/bin/bash

echo `date '+%Y-%m-%d %H:%M:%S'` : Starting to mirror contents of source
echo
rsync -avzu --delete --ignore-existing --stats /backup/source/* /backup/destination/latest
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
