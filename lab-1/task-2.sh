#!/bin/bash

read i
while [[ "$i" != "q" ]]
do 
	result+="$i"
	read i
done
echo $result
