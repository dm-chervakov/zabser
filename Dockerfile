#---------------------------------------------------------------------------
# Dockefile to build Docker Image of Zabbix Server running on Ubuntu
#---------------------------------------------------------------------------

FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get -y install wget \
			curl 

# Install zabbix
RUN wget https://repo.zabbix.com/zabbix/4.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.0-2+xenial_all.deb
RUN dpkg -i zabbix-release_4.0-2+xenial_all.deb
RUN apt update
RUN apt install -y zabbix-server-mysql
RUN apt install -y zabbix-frontend-php

# Make work dir 
# Copy config script for MySql and StartUp config
RUN mkdir /config
COPY config.sh start.sh /config/
RUN /config/config.sh

# Startup service - MySql and Apache2
CMD ["/bin/bash","/config/start.sh"]
EXPOSE 80
