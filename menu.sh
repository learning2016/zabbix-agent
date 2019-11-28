#!/bin/sh
#Shell menu
#Author qinliang
# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }
pwd=/etc/zabbix
pwd1=/etc/zabbix/zabbix_agentd.d

function Initialize_the () {
      sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
      setenforce 0
      yum install nmap -y
} 

function Linux_system_monitoring () {
      if grep -q 7. /etc/redhat-release; then
            rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
            yum -y install zabbix-sender zabbix-agent zabbix-get
            rm -rf /etc/zabbix/zabbix_agentd.conf
            rm -rf /etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf
      else
            rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm
            yum -y install zabbix-sender zabbix-agent zabbix-get
            rm -rf /etc/zabbix/zabbix_agentd.conf
            rm -rf /etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf
      fi
      
      cd $pwd
      if [ -e zabbix_agentd.conf ]; then
          echo "zabbix_agentd.conf [found]"
          rm -rf zabbix_agentd.conf
      else
          echo "zabbix_agentd.conf not found!!!download now..."
          if ! wget -c https://raw.githubusercontent.com/learning2016/zabbix-agent/master/zabbix_agentd.conf; then
              echo "Failed to download zabbix_agentd.conf, please download it to ${pwd} directory manually and try again."
              exit 1
          fi
      fi

      read -p "请输入Zabbix-Agent的Hostname:" Hostname
      echo "Hostname=$Hostname"
      echo "Hostname=$Hostname">>/etc/zabbix/zabbix_agentd.conf
      
      if grep -q 7. /etc/redhat-release; then
            systemctl start zabbix-agent.service
            systemctl enable zabbix-agent.service
            systemctl restart zabbix-agent.service;
      else
            chkconfig zabbix-agent on
            /etc/init.d/zabbix-agent start
            /etc/init.d/zabbix-agent restart
      fi
}

function Mysql_monitoring () {
      cd $pwd1 
      if [ -e input_mysql_ip.sh ]; then
          echo "input_mysql_ip.sh [found]"
          rm -rf input_mysql_ip.sh
      else
          echo "input_mysql_ip.sh not found!!!download now..."
          if ! wget -c https://raw.githubusercontent.com/learning2016/zabbix-agent/master/input_mysql_ip.sh; then
              echo "Failed to download input_mysql_ip.sh, please download it to ${pwd1} directory manually and try again."
              exit 1
          fi
      fi
      
      if [ -e nmap_mysql.sh ]; then
          echo "nmap_mysql.sh [found]"
          rm -rf nmap_mysql.sh
      else
          echo "nmap_mysql.sh not found!!!download now...."
          if ! wget -c https://raw.githubusercontent.com/learning2016/zabbix-agent/master/nmap_mysql.sh; then
              echo "Failed to download nmap_mysql.sh, please download it to ${pwd1} directory manually and try again."
              exit 1
          fi
      fi

      if [ -e userparameter_mysql.conf ]; then
          echo "userparameter_mysql.conf [found]"
          rm -rf userparameter_mysql.conf
      else
          echo "userparameter_mysql.conf not found!!!download now..."
      if ! wget -c https://raw.githubusercontent.com/learning2016/zabbix-agent/master/userparameter_mysql.conf; then
              echo "Failed to download userparameter_mysql.conf, please download it to ${pwd1} directory manually and try again."
              exit 1
          fi
      fi
     
      bash input_mysql_ip.sh
      if grep -q 7. /etc/redhat-release; then
            systemctl restart zabbix-agent.service;
      else
            /etc/init.d/zabbix-agent restart
      fi
}

function MongoDB_monitoring () {
      cd $pwd1
      if [ -e input_mongodb_ip.sh ]; then
          echo "input_mongodb_ip.sh [found]"
          rm -rf input_mongodb_ip.sh
      else
          echo "input_mongodb_ip.sh not found!!!download now..."
          if ! wget -c https://raw.githubusercontent.com/learning2016/zabbix-agent/master/input_mongodb_ip.sh; then
              echo "Failed to download input_mongodb_ip.sh, please download it to ${pwd1} directory manually and try again."
              exit 1
          fi
      fi
      
      if [ -e nmap_mongodb.sh ]; then
          echo "nmap_mongodb.sh [found]"
          rm -rf nmap_mongodb.sh
      else
          echo "nmap_mongodb.sh not found!!!download now..."
          if ! wget -c https://raw.githubusercontent.com/learning2016/zabbix-agent/master/nmap_mongodb.sh; then
              echo "Failed to download nmap_mongodb.sh, please download it to ${pwd1} directory manually and try again."
              exit 1
          fi
      fi

      if [ -e userparameter_mongodb.conf ]; then
          echo "userparameter_mongodb.conf [found]"
          rm -rf userparameter_mongodb.conf
      else
          echo "userparameter_mongodb.conf not found!!!download now..."
      if ! wget -c https://raw.githubusercontent.com/learning2016/zabbix-agent/master/userparameter_mongodb.conf; then
              echo "Failed to download userparameter_mongodb.conf, please download it to ${pwd1} directory manually and try again."
              exit 1
          fi
      fi
      
      bash input_mongodb_ip.sh
      if grep -q 7. /etc/redhat-release; then
            systemctl restart zabbix-agent.service;
      else
            /etc/init.d/zabbix-agent restart
      fi
}

function Redis_monitoring () {
      cd $pwd1 
      if [ -e input_redis_ip.sh ]; then
          echo "input_redis_ip.sh [found]"
          rm -rf input_redis_ip.sh
      else
          echo "input_redis_ip.sh not found!!!download now..."
          if ! wget -c https://raw.githubusercontent.com/learning2016/zabbix-agent/master/input_redis_ip.sh; then
              echo "Failed to download input_redis_ip.sh, please download it to ${pwd1} directory manually and try again."
              exit 1
          fi
      fi
      
      if [ -e nmap_redis.sh ]; then
          echo "nmap_redis.sh [found]"
          rm -rf nmap_redis.sh
      else
          echo "nmap_redis.sh not found!!!download now..."
          if ! wget -c https://raw.githubusercontent.com/learning2016/zabbix-agent/master/nmap_redis.sh; then
              echo "Failed to download nmap_redis.sh, please download it to ${pwd1} directory manually and try again."
              exit 1
          fi
      fi

      if [ -e userparameter_redis.conf ]; then
          echo "userparameter_redis.conf [found]"
          rm -rf userparameter_redis.conf
      else
          echo "userparameter_redis.conf not found!!!download now..."
          if ! wget -c https://raw.githubusercontent.com/learning2016/zabbix-agent/master/userparameter_redis.conf; then
              echo "Failed to download userparameter_redis.conf, please download it to ${pwd1} directory manually and try again."
              exit 1
          fi
      fi
      
      bash input_redis_ip.sh
      if grep -q 7. /etc/redhat-release; then
            systemctl restart zabbix-agent.service;
      else
            /etc/init.d/zabbix-agent restart
      fi
}

function Memcache_monitoring () {
      cd $pwd1
      if [ -e input_memcache_ip.sh ]; then
          echo "input_memcache_ip.sh [found]"
          rm -rf input_memcache_ip.sh
      else
          echo "input_memcache_ip.sh not found!!!download now..."
          if ! wget -c https://raw.githubusercontent.com/learning2016/zabbix-agent/master/input_memcache_ip.sh; then
              echo "Failed to download input_memcache_ip.sh, please download it to ${pwd1} directory manually and try again."
              exit 1
          fi
      fi
      
      if [ -e nmap_memcache.sh ]; then
          echo "nmap_memcache.sh [found]"
          rm -rf nmap_memcache.sh
      else
          echo "nmap_memcache.sh not found!!!download now..."
          if ! wget -c https://raw.githubusercontent.com/learning2016/zabbix-agent/master/nmap_memcache.sh; then
              echo "Failed to download nmap_memcache.sh, please download it to ${pwd1} directory manually and try again."
              exit 1
          fi
      fi

      if [ -e userparameter_memcache.conf ]; then
          echo "userparameter_memcache.conf [found]"
          rm -rf userparameter_memcache.conf
      else
          echo "userparameter_memcache.conf not found!!!download now..."
      if ! wget -c https://raw.githubusercontent.com/learning2016/zabbix-agent/master/userparameter_memcache.conf; then
              echo "Failed to download userparameter_memcache.conf, please download it to ${pwd1} directory manually and try again."
              exit 1
          fi
      fi
      
      bash input_memcache_ip.sh
      if grep -q 7. /etc/redhat-release; then
            systemctl restart zabbix-agent.service;
      else
            /etc/init.d/zabbix-agent restart
      fi
}

function menu () {
    cat << EOF
----------------------------------------
|***************菜单主页***************|
----------------------------------------
`echo -e "\033[33m 1)初始化Zabbix环境(必选)\033[0m"`
`echo -e "\033[33m 2)linux系统监控\033[0m"`
`echo -e "\033[33m 3)Mysql监控\033[0m"`
`echo -e "\033[33m 4)MongoDB监控\033[0m"`
`echo -e "\033[33m 5)Memcache监控\033[0m"`
`echo -e "\033[33m 6)Redis监控\033[0m"`
`echo -e "\033[33m 7)退出\033[0m"`
EOF
read -p "请输入对应产品的数字：" num1
case $num1 in
#初始化Zabbix环境
    1)
      #clear
      Initialize_the
      menu
      ;;
#linux系统监控。
    2)
      #clear
      Linux_system_monitoring
      menu
      ;;
#Mysql监控。
    3)
      #clear
      Mysql_monitoring
      menu
      ;;
#MongoDB监控。
    4)
      #clear
      MongoDB_monitoring
      menu
      ;;
#Memcache监控。
    5)
      #clear
      Memcache_monitoring
      menu
      ;;
#Redis监控。
    6)
      #clear
      Redis_monitoring
      menu
      ;;
#退出
    7)
      exit 0
esac
}
menu
