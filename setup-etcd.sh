#!/bin/bash
set -e

source env.config 

etcdctl mkdir /haproxy-config/${PROJECT_NAME}/mongo
etcdctl set haproxy-config/${PROJECT_NAME}/mongo/frontend/bind *:27017
etcdctl set haproxy-config/${PROJECT_NAME}/mongo/frontend/default_backend mongo-server
etcdctl set haproxy-config/${PROJECT_NAME}/mongo/backend/mongo-1 mongos:27017
