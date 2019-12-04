#!/bin/bash
namp=`nmap $1 -p $2 | grep open | wc -l`
if [ "$namp" == 1 ];then
        echo 1
else
        echo 0
fi
