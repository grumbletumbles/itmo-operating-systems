#!/bin/bash

home="/home/user/"
lastBackupDate=$(ls $home | grep -E "^Backup-" | sort -n | tail -1 | sed "s/Backup-//")
lastBackup="$home/Backup-$lastBackupDate"
today=$(date +"%Y-%m-%d")
nowTimes=$(date -d "$today" + "%s")
lastBackupTimes=$(date -d "lastBackupDate" + "%s")
totalTime=$(echo "(${nowTimes} - ${lastBackupTimes}) / 60 / 60 /24" | bc)
report="$home/.backup-report"

if [[ $totalTime > 7 || -z "lastBackupDate" ]];
then
	mkdir "$home/Backup-$today"
	for o in $(ls "$home/source")
	do
		cp "$home/source/$o" "$home/Backup-$today"
	done
	flist=$(ls "$home/source" | sed "s/^/\t/")
	echo -e "$today. Created:\n${flist}" >> $report
else
	changes=""
	for o in $(ls "$home/source")
	do
		if [[ -f "$lastBackup/$o" ]];
		then
			sourceSize=$(wc -c "$home/source/$o" | awk '{print $1}')
			backupSize=$(wc -c "$lastBackup/$o" | awk '{print $1}')
			totalSize=$(echo "$sourceSize - $backupSize" | bc)
			if [[ $totalSize != 0 ]];
			then
				mv "$lastBackup/$o" "$lastBackup/$o.$today"
				cp "$home/source/$o" "$lastBackup"
				changes="${changes}\n\t$o ($o.$today)"
			fi
		else
			cp "$home/source/$o" $lastBackup
			changes="${changes}\n\t$o"
		fi
	done
	changes=$(echo "$changes" | sed "s/&\\n//")
	if [[ ! -z "$changes" ]]; 
	then
		echo -e "$lastBackupDate. Updated:\n${changes}" >> $report	
	fi
fi
