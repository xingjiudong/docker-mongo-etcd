#!/bin/bash
set -e

#Env Information
CLUSTER_PATH=$1
: ${KEYFILE_PATH:=/etc/keyfile}

#Created Mongodb_Keyfile
sudo mkdir -p ${KEYFILE_PATH} 
sudo openssl rand -base64 741 > ${KEYFILE_PATH}/mongodb-keyfile
sudo chmod 600 ${KEYFILE_PATH}/mongodb-keyfile 
sudo chown 999 ${KEYFILE_PATH}/mongodb-keyfile

#Create Etcd For Mongo
etcdctl set ${CLUSTER_PATH:-/mongo-config}/mongodb-keyfile < ${KEYFILE_PATH}/mongodb-keyfile
