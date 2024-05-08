#!/bin/bash

if [[ $PWD == $HOME ]]
then 
	echo "ok"
	exit 0
else
	echo "error"
	exit 1
fi
