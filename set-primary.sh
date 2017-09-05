#!/bin/bash
set -e
source ./env.config

#Get mongodb replset primary node;
SERVER_NAME=` docker-compose ${COMPOSE_OPT} $@ exec rs0node1 bash -c \
         "echo 'rs.status().members.find(r=>r.state===1).name;' | mongo  -u ${MONGO_INITDB_ROOT_USERNAME} -p ${MONGO_INITDB_ROOT_PASSWORD} --authenticationDatabase admin" \
         | grep rs0 \
         | sed 's/:[0-9][0-9][0-9][0-9][0-9]//g'`

SERVER_PORT=` docker-compose ${COMPOSE_OPT} $@ exec rs0node1 bash -c \
         "echo 'rs.status().members.find(r=>r.state===1).name;' | mongo  -u ${MONGO_INITDB_ROOT_USERNAME} -p ${MONGO_INITDB_ROOT_PASSWORD} --authenticationDatabase admin" \
         | grep rs0 \
         | sed 's/.*://g'` 

#Set etcd for mongodb replset primary node;
etcdctl set /haproxy-config/mongo/server_name ${SERVER_NAME}
etcdctl set /haproxy-config/mongo/server_port ${SERVER_PORT}
