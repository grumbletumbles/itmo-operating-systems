#!/bin/bash

sh loop.sh&pid0=$!
sh loop.sh&pid1=$!
sh loop.sh&pid1=$!

while true;
do
	cpu=$(ps -p $pid0 -o $cpu | tail -n +2)
	if [[ $cpu -gt 10 ]];
	do
		renice +1 -p $pid0
	done

	if [[ $cpu -lt 9 ]];
	do
		renice -1 -p $pid0
	done
done
#renice +10 -p $pid0
