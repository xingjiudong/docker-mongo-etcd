#!/bin/bash
set -e
mkdir -p /etc/mongo-files
etcdctl get /mongo-config/mongodb-keyfile > /etc/mongo-files/mongodb-keyfile

docker run --net=host --name mongo-${HOSTNAME} \
--restart=unless-stopped \
-v /etc/mongo-files/data:/data/db \
-v /etc/mongo-files:/opt/keyfile \
-v /etc/localtime:/etc/localtime:ro \
-p 27017:27017 \
-d mongo \
--smallfiles \
--keyFile /opt/keyfile/mongodb-keyfile \
--replSet "rs0"
