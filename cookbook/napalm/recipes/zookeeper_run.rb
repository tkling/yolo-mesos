execute <<-EOH
  docker run -e ZK_SERVER_ID=#{node['zk_server_id']} \
    --restart=on-failure:10 \
    --name zookeeper \
    -p 2181:2181 -p 2888:2888 -p 3888:3888 \
    -e HOSTNAME=`hostname` \
    -e HOSTS=core1,core2,core3 \
    -m 2g \
    --volumes-from zookeeper-data \
    --volumes-from zookeeper-data-log boritzio/docker-zookeeper
EOH