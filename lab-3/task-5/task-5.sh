#!/bin/bash

mkfifo pipe
./handler.sh&./generator.sh
rm pipe
