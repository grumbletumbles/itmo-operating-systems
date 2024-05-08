#!/bin/bash

max=0
max_pid=0
for pid_dir in /proc/[0-9]*
do
	if [ -f "$pid_dir/status" ];
	then
		mem=$(grep -i 'VmRSS' "$pid_dir/status" | awk '{ print $2 }')
		if [[ $mem -ge $max ]];
		then
			max=$mem
			max_pid=$(basename $pid_dir)
		fi
	fi
done

echo "pid of proccess with max memory usage: "$max_pid" using memory: "$max
top -bo RES | head -n8 | tail -n1 | awk ' {print "using top: pid="$1" memory="$6}'
