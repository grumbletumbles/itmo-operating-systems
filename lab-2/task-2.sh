#!/bin/bash

ps -eo pid,command | awk '$2 ~ "^/sbin/" { print($2)}'
