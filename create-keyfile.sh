#!/bin/bash
set -e

#Env Information 
CLUSTER_PATH=$1
: ${KEYFILE:=/etc/mongo-files/mongodb-keyfile}

#Created Mongodb_Keyfile
sudo mkdir -p /etc/mongo-files 
sudo openssl rand -base64 741 > ${KEYFILE} 
sudo chmod 600 ${KEYFILE} 
sudo chown 999 ${KEYFILE} 

#Create Etcd For Mongo
etcdctl set ${CLUSTER_PATH:-/mongo-config}/mongodb-keyfile < ${KEYFILE} 
