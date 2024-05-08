#!/bin/bash

# file /var/log/anaconda/syslog doesn't exist on this machine
# to check the script you can check it on vm
awk '$2 == "INFO" { print }' /var/log/anaconda/syslog > info.log
