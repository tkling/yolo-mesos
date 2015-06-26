execute <<-EOH
  docker run \
    -d \
    --restart=on-failure:10 \
    --net host \
    --name marathon \
    -m 1g \
    -e MARATHON_MASTER=zk://192.168.50.11:2181,192.168.50.12:2181,192.168.50.13:2181/mesos \
    -e MARATHON_ZK=zk://192.168.50.11:2181,192.168.50.12:2181,192.168.50.13:2181/marathon \
    -e HOSTNAME=`hostname` \
    boritzio/docker-marathon
EOH