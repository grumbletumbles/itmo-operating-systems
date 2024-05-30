#!/bin/bash

home="/home/user"
lastBackupDate=$(ls $home | grep -E "^Backup-" | sort -n | tail -1 | sed "s/^Backup-//")
lastBackup="$home/Backup-$lastBackupDate"

if [[ -z "$lastBackupDate" ]];
then
	echo "Backup not found"
	exit 1
fi

if [[ ! -d "$home/restore" ]];
then
	mkdir "$home/restore"
else
	rm -r "$home/restore"
	mkdir "$home/restore"
fi

for f in $(ls $lastBackup | grep -Ev "\.[0-9]{4}-[0-9]{2}-[0-9]{2}$");
do
	cp "$lastBackup/$f" "$home/restore/$f"
done
