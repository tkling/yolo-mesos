#
# Cookbook Name:: napalm
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#


bash "setup and install docker" do
  code "sed -i 's/^GRUB_CMDLINE_LINUX=\"\"/GRUB_CMDLINE_LINUX=\"cgroup_enable=memory swapaccount=1\"/' /etc/default/grub && \
        LVM_SUPPRESS_FD_WARNINGS=true update-grub && \
        echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list && \
        wget -qO- https://get.docker.io/gpg | apt-key add - && \
        apt-get update"	
end

package "lxc-docker" do
  action :install
end

directory "/disk/ssd/data/zookeeper" do
  recursive true
end

directory "/disk/ssd/log/zookeeper" do
  recursive true
end

execute "docker run -d -v /disk/ssd/data/zookeeper/data:/data --name zookeeper-data boritzio/docker-base true"
execute "docker run -d -v /disk/ssd/log/zookeeper:/data-log --name zookeeper-data-log boritzio/docker-base true"

