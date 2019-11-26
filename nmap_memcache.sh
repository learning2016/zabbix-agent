#!/bin/bash
namp=`nmap $ip -p 11211 | grep open | wc -l`
if [ "$namp" == 1 ];then
        echo 0
else
        echo 1
fi
