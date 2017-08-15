#!/bin/bash
set -e

source ./env.config

#Env Information
CLUSTER_PATH=$1
: ${KEYFILE:=/etc/keyfile/mongodb-keyfile}

#Created Mongodb_Keyfile
sudo mkdir -p /etc/keyfile
sudo openssl rand -base64 741 > ${KEYFILE}
sudo chmod 600 ${KEYFILE}
sudo chown 999 ${KEYFILE}

#Create Etcd For Mongo
etcdctl set ${CLUSTER_PATH:-/mongo-config}/mongodb-keyfile < ${KEYFILE}

docker-compose ${COMPOSE_OPT} up -d
