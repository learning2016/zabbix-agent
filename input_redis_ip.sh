#!/bin/bash
read -p "请输入Redis的IP:" ip
echo "$ip"
i1="ip="
i2=$i1$ip
sed "1 a$i2" -i /etc/zabbix/zabbix_agentd.d/nmap_redis.sh
