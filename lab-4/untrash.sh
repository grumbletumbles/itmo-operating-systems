#!/bin/bash

trashdir="/home/user/.trash"
trashlog="/home/user/.trash.log"
home="/home/user"
labdir="/home/user/itmo-operating-systems/lab-4"

if [[ $# > 1 ]];
then
	echo "too many arguments"
	exit 1
fi

if [[ $# < 1 ]];
then
	echo "too few arguments"
	exit 1
fi

if [[ ! -d $trashdir ]];
then
	echo "trash directory not found"
	exit 1
fi

if [[ ! -f $trashlog ]];
then
	echo "trash log file not found"
	exit 1
fi

if [[ $1 == "" ]];
then
	echo "bad input"
	exit 1
fi

if [[ $1 == "." ]] || [[ $1 == ".." ]];
then
	echo "bad input"
	exit 1
fi

if [[ ! $1 =~ ^[0-9a-zA-Z._-]+$ ]];
then
	echo "bad input"
	exit 1
fi

f=$1
a=""
# TODO change the lab dir to the correct one
for i in $(grep "$1" $trashlog | awk '{ print $1 }')
do
	a=$(basename $i)
	if [ $a == $f ];
	then 
		break
	fi
done

if [[ $a != $f ]];
then
	echo "file not found in trash log"
	exit 1
fi

for i in $(grep "$1" $trashlog | awk '{ print $NF }')
do
	file=$(grep $i $trashlog | awk '{ $NF=""; print $0 }')
	file=$(echo "$file" | sed 's/ *$//')
	ans=""
	read -p "$file Are you sure?: [y/n] " ans
	case "$ans" in
		"y")
			newfilename=""
			num=$i
			restoredir=$(echo "$file" | awk 'BEGIN{FS=OFS="/"}; { $NF=""; print $0 }')
			filename=$(echo "$file" | awk 'BEGIN{FS="/"}; { print $NF }')
			if [[ ! -d $restoredir ]];
			then
				echo "Directory ${restoredir} not found. File \"${filename}\" will be restored in home directory."
				if [[ -f "${home}/${filename}" ]];
				then
					read -p "File \"${filename}\" already exists. Enter the new name: " newfilename
					ln "$trashdir/$num" "$home/$newfilename"
					rm "$trashdir/$num" 
				else
					ln "$trashdir/$num" "$home/$filename"
					rm "$trashdir/$num"
				fi
			else
				if [[ -f "$filename" ]];
				then
					read -p "File \"$filename\" already exists. Enter the new name: " newfilename
					ln "$trashdir/$num" "$restoredir/$newfilename"
					rm "$trashdir/$num" 
				else
					ln "$trashdir/$num" "$restoredir/$filename"
					rm "$trashdir/$num" 
				fi
			fi
			sed "/$num/d" $trashlog > .trash.log2 && mv .trash.log2 $trashlog
			echo "success"
			;;
		*)
			continue
			;;
	esac
done
