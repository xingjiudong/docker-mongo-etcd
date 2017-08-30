#!/bin/bash
set -e

etcdctl --endpoints http://${ETCD_CLIENT_IP}:2379 get /mongo-config/mongodb-keyfile/${REPLSET_NAME} > /mongodb-keyfile
chmod 600 /mongodb-keyfile
chown mongodb /mongodb-keyfile
source /usr/local/bin/docker-entrypoint.sh
