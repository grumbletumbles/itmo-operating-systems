#!/bin/bash

while true;
do
	read line
	echo "$line" > pipe
	if [[ "$line" == "QUIT" ]];
	then
		echo "generator done"
		exit 0
	fi

	if [[ "$line" != "+" && "$line" != "*" && "$line" != [0-9] ]];
	then
		echo "generator error"
		exit 1
	fi
done
