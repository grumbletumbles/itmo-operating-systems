#!/bin/bash

sh loop.sh&pid0=$!
sh loop.sh&pid1=$!
sh loop.sh&pid1=$!

nice=0

while true;
do
	cpu=$(ps -p $pid0 -o %cpu | tail -n +2)
	if [[ $(echo "$cpu > 10" | bc -l) ]];
	then
		nice=$(($nice + 1))
	fi

	if [[ $(echo "$cpu < 9" | bc -l) ]];
	then
		nice=$(($nice - 1))
	fi
	renice $nice -p $pid0
	sleep .1
done
#renice +10 -p $pid0
