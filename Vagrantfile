# -*- mode: ruby -*-
# vi: set ft=ruby :

# cockpit Vagrantfile

VAGRANTFILE_API_VERSION = "2"
BOX_MEM = ENV['BOX_MEM'] || "1024"
BOX_CORE = ENV['BOX_CORE'] || "1"
BOX_NAME =  ENV['BOX_NAME'] || "puppetlabs/centos-7.0-64-puppet"

Vagrant.require_version ">= 1.5"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |cockpit|
  cockpit.vm.box = BOX_NAME
  cockpit.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", BOX_MEM]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
    v.customize ["modifyvm", :id, "--cpus", BOX_CORE]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end
  cockpit.vm.network "forwarded_port", guest: 80, host: 8080
  cockpit.vm.network "forwarded_port", guest: 443, host: 8443
  cockpit.vm.network "forwarded_port", guest: 9090, host: 9090
  cockpit.vm.network "private_network", ip: "192.168.33.10"
  cockpit.vm.provision "puppet" do |puppet|
    puppet.module_path = "modules"
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "default.pp"
    #puppet.options = "--verbose --debug"
  end
end
