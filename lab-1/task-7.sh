#!/bin/bash

grep -E -I -o -h -s "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+" /etc/* | tr '\n' ', ' > emails.lst
