#!/bin/bash

dates=$(date "+%F|%F")

mkdir ~/test && { echo "catalog was successfully created" > ~/report ; touch ~/test/$dates ; }
ping net_nikogo.ru || echo "${dates} ERROR CONNECTING TO HOST" >> ~/report
