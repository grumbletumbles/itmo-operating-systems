#!/bin/bash

ps aux | awk '$1 == "grumble+" { print }' | wc -l
ps aux | awk '$1 == "grumble+" { print($2":"$11)}'  
