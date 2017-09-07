#!/bin/bash
set -e
source ./env.config

#Get mongodb replset primary node;
PRIMARY_NODE=` docker-compose ${COMPOSE_OPT} $@ exec rs0node1 bash -c \
         "echo 'rs.status().members.find(r=>r.state===1).name;' | mongo  -u ${MONGO_INITDB_ROOT_USERNAME} -p ${MONGO_INITDB_ROOT_PASSWORD} --authenticationDatabase admin" \
         | grep rs0` 

#Set etcd for mongodb replset primary node;
etcdctl set haproxy-config/${PROJECT_NAME}/mongo/backend/mongo-1 ${PRIMARY_NODE}
