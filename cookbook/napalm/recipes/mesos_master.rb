directory "/disk/ssd/data/mesos/workdir" do
  recursive true
end

execute "docker run -d -v /disk/ssd/data/mesos/workdir:/workdir --name mesos-workdir boritzio/docker-base true"

execute <<-EOH
  docker run \
    --restart=on-failure:10 \
    --name mesos-master \
    -p 5050:5050 \
    -m 1g \
    -e MESOS_ZK=zk://192.168.50.11:2181,192.168.50.12:2181,192.168.50.13:2181/mesos \
    -e MESOS_CLUSTER=napalm-mesosphere \
    -e MESOS_WORK_DIR=/workdir \
    -e MESOS_LOG_DIR=/var/log/mesos/ \
    -e MESOS_QUORUM=2 \
    -e HOSTNAME=`hostname` \
    -e IP=`hostname -i` \
    --volumes-from mesos-workdir \
    boritzio/docker-mesos-master
EOH
