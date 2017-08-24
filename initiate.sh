#!/bin/bash

source ./env.config

# Env Information
: ${USERNAME:=siteRootAdmin}
: ${PASSWORD:=password}
: ${REPLSET_NAME:=rs0}

# Replset Init and Create Auth User
docker-compose ${COMPOSE_OPT} exec rs0node1 bash -c "echo 'rs.initiate();sleep(1000);' | mongo admin"
docker-compose ${COMPOSE_OPT} exec rs0node1 bash -c "echo 'db.createUser({user: \"${USERNAME}\", pwd: \"${PASSWORD}\", roles: [ { role: \"root\", db: \"admin\" } ] });' | mongo admin"

echo "Intializing replica rs0 set"
replicate="cfg = rs.conf(); cfg.members[0].host = \"${REPLSET_NAME}node1\"; rs.reconfig(cfg); rs.add(\"${REPLSET_NAME}node2\"); rs.add(\"${REPLSET_NAME}node3\"); rs.status();"
docker-compose ${COMPOSE_OPT} exec ${REPLSET_NAME}node1 bash -c "echo '${replicate}' | mongo  -u ${USERNAME} -p ${PASSWORD} --authenticationDatabase admin"

