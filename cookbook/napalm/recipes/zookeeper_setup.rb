directory "/disk/ssd/data/zookeeper" do
  recursive true
end

directory "/disk/ssd/log/zookeeper" do
  recursive true
end

execute "docker run -d -v /disk/ssd/data/zookeeper/data:/data --name zookeeper-data boritzio/docker-base true"
execute "docker run -d -v /disk/ssd/log/zookeeper:/data-log --name zookeeper-data-log boritzio/docker-base true"
