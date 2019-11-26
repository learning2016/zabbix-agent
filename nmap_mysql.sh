#!/bin/bash
namp=`nmap $ip -p 3306 | grep open | wc -l`
if [ "$namp" == 1 ];then
        echo 0
else
        echo 1
fi
