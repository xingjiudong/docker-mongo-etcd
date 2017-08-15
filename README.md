# Create Keyfile With ETCD 
sudo ./create-keyfile.sh $CLUSTER_PATH

# Create Mongo-Cluster
./create-mongodb.sh

# Initiate Mongo-Cluster
./initiate 
