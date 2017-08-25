# How to

1. Create keyfile for mongo
sudo ./keyfile.sh

2. Create Mongo-Cluster and haproxy
./create-mongodb.sh 

3. Initiate Mongo-Cluster
./initiate.sh 

4.Connect Mongo with client
default:
siteRootAdmin@${HAPROXY_NODE}:27017

