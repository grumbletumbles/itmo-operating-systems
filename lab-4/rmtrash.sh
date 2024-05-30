#!/bin/bash

if [[ $# > 1 ]];
then
	echo "too many arguments"
	exit 1
fi

if [[ $# < 1 ]];
then
	echo "not enough arguments"
	exit 1
fi

if [[ ! -f $1 ]];
then
	echo "file doesn't exist"
	exit 1
fi

if [[ ! -e "/home/user/.trash" ]]
then
	mkdir /home/user/.trash
fi

if [[ ! -f "/home/user/.trash.log" ]] 
then
	touch /home/user/.trash.log
fi

value=$(cat /home/user/.trash.log | sort -nk2,2 | tail -1 | awk '{ print $1}')
value=$(($value + 1))
ln "$PWD/$1" "/home/user/.trash/$value"

echo $value $(readlink -f $1) >> /home/user/.trash.log
rm -- "$1"
