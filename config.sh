#!/bin/bash
# ------------------------------------------------------------------------------------------------
# Config Mysql and Apache2
# Restart service
# ------------------------------------------------------------------------------------------------
/etc/init.d/mysql start

cat <<EOD | mysql -uroot -pzabbix
        CREATE DATABASE zabbixdb character set utf8 collate utf8_bin;
        CREATE USER 'zabbix' IDENTIFIED BY 'zabbix';  
        GRANT ALL PRIVILEGES ON zabbixdb.* TO 'zabbix' WITH GRANT OPTION;
        FLUSH PRIVILEGES;
EOD

zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz \
	| mysql -u zabbix --password=zabbix zabbixdb

mv /etc/php/7.0/apache2/php.ini \
	/etc/php/7.0/apache2/php.ini.example

grep ';' -v /etc/php/7.0/apache2/php.ini.example | grep -v ^$ \
	> /etc/php/7.0/apache2/php.ini


cat <<EOF >> /etc/php/7.0/apache2/php.ini
 date.timezone = 'Europe/Kiev'
EOF


mv /etc/zabbix/zabbix_server.conf \
	/etc/zabbix/zabbix_server.conf.example

grep ^# -v /etc/zabbix/zabbix_server.conf.example | grep -v ^$ | grep -v ^DB* \
	> /etc/zabbix/zabbix_server.conf


cat <<EOF >> /etc/zabbix/zabbix_server.conf
  
  DBHost=localhost
  DBName=zabbixdb
  DBUser=zabbix
  DBPassword=password 

EOF

service apache2 restart
service zabbix-server restart

