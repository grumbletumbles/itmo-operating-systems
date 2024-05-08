#!/bin/bash

for pid in $(ps -Ao pid | tail -n +2);
do
	path="/proc/"$pid
	ppid=$(grep -Ehis "ppid:\s+(.+)" $path"/status" | grep -o "[0-9]\+")
	runtime=$(grep -Ehis "se\.sum_exec_runtime(.)+:\s+(.+)" $path"/sched" | awk '{ print $3 }')
	nrswitches=$(grep -Ehis "nr_switches(.)+:\s+(.+)" $path"/sched" | awk '{ print $3 }')
	if [ -z $ppid ];
	then 
		continue
	fi
	if [ -z $runtime ] || [ -z $nrswitches ];
	then 
		art=0
	else 
		art=$(echo "scale=2; $runtime/$nrswitches" | bc | awk '{ printf "%.2f", $0 }')
	fi
	echo "$pid $ppid $art"
done | sort -nk2 | awk '{ print "ProccessID="$1" : Parent_ProccessID="$2" : Average_Running_Time="$3 }' > task-4.out
