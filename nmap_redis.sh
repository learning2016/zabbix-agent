#!/bin/bash
namp=`nmap $ip -p 6379 | grep open | wc -l`
if [ "$namp" == 1 ];then
        echo 0
else
        echo 1
fi
