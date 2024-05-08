#!/bin/bash

this_pid=$$
ps -eo pid,ppid,cmd --sort=start_time | tail -n +2 | grep -v -e "$this_pid" -e "$$" | tail -n 2 | awk '{ print $1" "$2" "$3}' > task-3.out

