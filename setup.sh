#!/bin/bash
set -Eeuo pipefail

: ${ETCD_CLIENT_IP}
: ${CLUSTER_PATH}
: ${REPLSET_NAME}
: ${KEYFILE_PATH}

mkdir -p ${KEYFILE_PATH} 
etcdctl --endpoints http://${ETCD_CLIENT_IP:-127.0.0.1}:2379 get ${CLUSTER_PATH:-/mongo-config}/mongodb-keyfile > ${KEYFILE_PATH}/mongodb-keyfile
chmod 600 ${KEYFILE_PATH}/mongodb-keyfile
chown 999 ${KEYFILE_PATH}/mongodb-keyfile
mongod --replSet ${REPLSET_NAME} --smallfiles --dbpath /data/db --keyFile ${KEYFILE_PATH}/mongodb-keyfile
