#!/bin/bash

./handler.sh&pid=$!
./generator.sh $pid
