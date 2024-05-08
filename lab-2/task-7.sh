#!/bin/bash

for temp in $(ps -Ao pid,command | tail -n +2 | awk '{ print $1":"$2 }');
do
	pid=$(echo $temp | awk -F ":" '{ print $1 }')
	command=$(echo $temp | awk -F ":" '{ print $2 }')
	path="/proc/"$pid
	if [ -f $path/io ];
	then 
		bytes=$(grep -h "read_bytes:" $path/io | sed "s/[^0-9]*//")
		echo "$pid $command $bytes"
	fi
done | sort -nk1 > a
sleep 1m
for temp in $(ps -Ao pid,command | tail -n +2 | awk '{ print $1":"$2 }');
do
	pid=$(echo $temp | awk -F ":" '{ print $1 }')
	command=$(echo $temp | awk -F ":" '{ print $2 }')
	path="/proc/"$pid
	if [ -f $path/io ];
	then 
		bytes=$(grep -h "read_bytes:" $path/io | sed "s/[^0-9]*//")
		echo "$pid $command $bytes"
	fi
done | sort -nk1 > b
cat a |
while read string
do
	pid=$(awk '{ print $1 }' <<< $string)
	command=$(awk '{ print $2 }' <<< $string)
	mem1=$(awk '{ print $3 }' <<< $string)
	mem2=$(cat b | awk -v id="$pid" '{ if ($1 == id) print $3}')
	result=$(echo "$mem2-$mem1" | bc)
	echo $pid" : "$command" : "$result
done | sort -t ':' -nrk3 | head -3 > task-7.out

