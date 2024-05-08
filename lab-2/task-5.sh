#!/bin/bash

curppid=0
sum=0
avg=0
count=0

echo -e "$(<task-4.out)\n" | sed "s/[^0-9.]\+/ /g" | sed "s/^ //g" | 
while read string
do
	pid=$(awk '{ print $1 }' <<< $string)
	ppid=$(awk '{ print $2 }' <<< $string)
	art=$(awk '{ print $3 }' <<< $string)
	if [[ $curppid == $ppid ]];
	then
		sum=$(echo "$sum+$art" | bc | awk '{ printf "%.2f", $0 }')
		((count++))
	else
		avg=$(echo "scale=2; $sum/$count" | bc | awk '{ printf "%.2f", $0}')
		echo "Average_Children_Running_Time_Of_ParentID="$curppid" is "$avg
		sum=$art
		curppid=$ppid
		count=1
	fi
	if [[ -n $pid ]];
	then
		echo "ProcessID="$pid" : Parent_ProcessID="$ppid" : Average_Running_Time="$art
	fi
done > task-5.out

