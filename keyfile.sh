#!/bin/bash
set -e

source ./env.config

#Created Mongodb-Keyfile
openssl rand -base64 741 > ./mongodb-keyfile

#Create Etcd For Mongo
etcdctl set /mongo-config/mongodb-keyfile/${REPLSET_NAME:-rs0} < ./mongodb-keyfile
rm ./mongodb-keyfile
