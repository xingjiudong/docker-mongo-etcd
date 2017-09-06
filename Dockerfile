FROM mongo:latest

MAINTAINER xjd <25635680@qq.com>

# Env config
ENV ETCD_VERSION v2.3.7

RUN	apt-get update && apt-get install -y --no-install-recommends wget && rm -rf /var/lib/apt/lists/* \
        && wget https://github.com/coreos/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz --no-check-certificate \
        && tar xvzf etcd-${ETCD_VERSION}-linux-amd64.tar.gz \
        && mv etcd-${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin/etcdctl \
        && rm -rf etcd-${ETCD_VERSION}-linux-amd64 \
        && rm -rf etcd-${ETCD_VERSION}-linux-amd64.tar.gz
        
COPY ./etcd-entrypoint.sh  /
ENTRYPOINT ["/etcd-entrypoint.sh"]

