# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define :workstation do |c|
    # Personnalisation de la box (OS)
    c.vm.box = "ubuntu14.04-chef"
    c.vm.box_url = "http://repository.srv.gov.pf/box/ubuntu14.04-chef-vb.box"

    # Montage d'un repertoire
    config.vm.synced_folder "chef", "/root/.chef"

    # Personnalisation du hostname dans la VM
    c.vm.hostname = "workstation.os.gov.pf"

    # Configuration du provisionner SHELL
    config.vm.provision "shell", path: "bootstrap.sh"

    # Personnalisation du provider : virtualbox
    c.vm.provider "virtualbox" do |v|
      v.gui = false
      v.name = "workstation"
      v.memory = 512
      v.cpus = 1
    end
  end

end
