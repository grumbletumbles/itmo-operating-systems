#!/bin/bash

if [[ $1 -gt $2 ]]
then m=$1
else m=$2
fi
if [[ $3 -gt $m ]]
then m=$3
fi
echo $m
