#!/bin/bash

result=1
command="+"
tail -f pipe | 
while true
do
	read line
	case $line in 
		"+")
			command="$line"
			echo "in addition mode" 
			;;
		"*")
			command="$line"
			echo "in multiplication mode"
			;;
		[0-9])
			case $command in 
				"+")
					result=$(($result + $line))
					echo $reuslt
					;;
				"*")
					result=$(($result * $line))
					echo $result
			esac
			;;
		"QUIT")
			echo "exited"
			exit 0
			;;
		*)
			killall tail
			echo "handler error"
			exit 1
			;;
	esac
done
