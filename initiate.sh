#!/bin/bash

source ./env.config

docker-compose ${COMPOSE_OPT} $@ exec mongos bash -c "echo 'db.createUser({user: \"${MONGO_INITDB_ROOT_USERNAME}\", pwd: \"${MONGO_INITDB_ROOT_PASSWORD}\", roles: [ { role: \"root\", db: \"admin\" } ] });' | mongo admin"
