# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  [1, 2, 3].each do |num|
    config.vm.define "core#{num}" do |box|
      box.vm.box = "12.04-opscode"
      box.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box"

      box.vm.hostname = "core#{num}"
      box.vm.network 'private_network', ip: "192.168.50.#{num + 10}", virtualbox__intnet: true

      box.vm.provider :virtualbox do |vm|
        vm.memory = 512
        vm.cpus = 2
      end

      box.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = "./cookbook"
        chef.json = { 'zk_server_id' => num }

        # 1st run - setup
        chef.add_recipe "napalm"
        chef.add_recipe "napalm::zookeeper_setup"

        # 2nd run - start zk and mesos master once the nodes are up and responding
        # Comment out the recipes above for run #2!
        # chef.add_recipe 'napalm::zookeeper_run'
        # chef.add_recipe 'napalm::mesos_master'
      end
    end
  end
end
