#!/bin/bash

source ./env.config

# Env Information
: ${USERNAME:=siteRootAdmin}
: ${PASSWORD:=password}
: ${COMPOSE_OPT:=-H tcp://localhost:9999}
: ${REPLSET_NAME:=mongors1}

# Replset Init and Create Auth User
docker-compose ${COMPOSE_OPT} exec ${REPLSET_NAME}n1 bash -c "echo 'rs.initiate();sleep(1000);' | mongo admin"
docker-compose ${COMPOSE_OPT} exec ${REPLSET_NAME}n1 bash -c "echo 'db.createUser({user: \"${USERNAME}\", pwd: \"${PASSWORD}\", roles: [ { role: \"root\", db: \"admin\" } ] });' | mongo admin"


echo "Intializing replica rs1 set"
replicate="cfg = rs.conf(); cfg.members[0].host = \"${REPLSET_NAME}n1\"; rs.reconfig(cfg); rs.add(\"${REPLSET_NAME}n2\"); rs.add(\"${REPLSET_NAME}n3\"); rs.status();"
docker-compose ${COMPOSE_OPT} exec ${REPLSET_NAME}n1 bash -c "echo '${replicate}' | mongo  -u ${USERNAME} -p ${PASSWORD} --authenticationDatabase admin"

