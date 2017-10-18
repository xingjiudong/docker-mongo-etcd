#!/bin/bash
set -e
source ./env.config
CONN=$1

#Get mongodb replset primary node;
PRIMARY_NODE=` docker-compose ${COMPOSE_OPT} exec ${CONN} bash -c \
         "echo 'rs.status().members.find(r=>r.state===1).name;' | mongo  -u ${MONGO_INITDB_ROOT_USERNAME} -p ${MONGO_INITDB_ROOT_PASSWORD} --authenticationDatabase admin" \
         | sed -n '4,4p'`

#Set etcd for mongodb replset primary node;
etcdctl set haproxy-config/${PROJECT_NAME}/mongo/backend/mongo-1 ${PRIMARY_NODE}
