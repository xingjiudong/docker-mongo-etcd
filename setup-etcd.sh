#!/bin/bash
set -e

source ./.env

etcdctl mkdir /haproxy-config/${COMPOSE_PROJECT_NAME}/mongo
etcdctl set haproxy-config/${COMPOSE_PROJECT_NAME}/mongo/frontend/bind *:27017
etcdctl set haproxy-config/${COMPOSE_PROJECT_NAME}/mongo/frontend/default_backend mongo-server
etcdctl set haproxy-config/${COMPOSE_PROJECT_NAME}/mongo/backend/mongo-1 mongo1:27017
