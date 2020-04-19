# -*- mode: ruby -*-
# vi: set ft=ruby :

CONFIG_VERSION="2"
ICECAST_PORT=4040

Vagrant.configure(CONFIG_VERSION) do |config|
  config.vm.box = "hashicorp/bionic64"
  config.vm.provision "ansible" do |ansible|
  config.vm.network "forwarded_port", guest: ICECAST_PORT, host: ICECAST_PORT 
    ansible.playbook = "ansible/playbook.yml"
  end
end