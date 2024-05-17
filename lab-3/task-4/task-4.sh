#!/bin/bash

sh loop.sh&pid0=$!
sh loop.sh&pid1=$!
sh loop.sh&pid1=$!

while true;
do
	cpu=$(ps -p $pid0 -o %cpu | tail -n +2)
	if [[ $(echo "$cpu > 10" | bc -l) ]];
	do
		renice 1 -p $pid0
	done

	if [[ $(echo "$cpu < 9" | bc -l) ]];
	do
		renice -1 -p $pid0
	done
	sleep .1
done
#renice +10 -p $pid0
