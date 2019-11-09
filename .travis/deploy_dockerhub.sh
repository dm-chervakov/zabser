#!/bin/sh

echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
docker tag zabbix-server $DOCKER_USER/zabbix-server
docker push $DOCKER_USER/zabbix-server

