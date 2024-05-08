#!/bin/bash

echo -e "1. nano\n2. vim\n3. links\n4. quit"
read i
case $i in
1 )
nano
;;
2 )
vim
;;
3 )
# note: doesn't work
links
;;
4 )
exit;;
esac
