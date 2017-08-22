#!/bin/bash
set -e

etcdctl --endpoints http://${ETCD_CLIENT_IP:-127.0.0.1}:2379 get ${CLUSTER_PATH:-/mongo-config}/mongodb-keyfile > /mongodb-keyfile
chmod 600 /mongodb-keyfile
chown mongodb /mongodb-keyfile
mongod --replSet ${REPLSET_NAME} --smallfiles --dbpath /data/db --keyFile /mongodb-keyfile
