#!/bin/bash

source ./env.config

# Replset Init and Create Auth User
docker-compose ${COMPOSE_OPT} $@ exec rs0node1 bash -c "echo 'rs.initiate();sleep(1000);' | mongo admin"
docker-compose ${COMPOSE_OPT} $@ exec rs0node1 bash -c "echo 'db.createUser({user: \"${MONGO_INITDB_ROOT_USERNAME}\", pwd: \"${MONGO_INITDB_ROOT_PASSWORD}\", roles: [ { role: \"root\", db: \"admin\" } ] });' | mongo admin"

echo "Intializing replica rs0 set"
replicate="cfg = rs.conf(); cfg.members[0].host = \"rs0node1\"; rs.reconfig(cfg); rs.add(\"rs0node2\"); rs.add(\"rs0node3\"); rs.status();"
docker-compose ${COMPOSE_OPT} $@ exec rs0node1 bash -c "echo '${replicate}' | mongo  -u ${MONGO_INITDB_ROOT_USERNAME} -p ${MONGO_INITDB_ROOT_PASSWORD} --authenticationDatabase admin"

