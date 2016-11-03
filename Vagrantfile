VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.provider :virtualbox do |vb|
        vb.name = "dotfiles"
        vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
        vb.memory = 1024
        vb.cpus = 2
    end

    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "dotfiles"
    config.vm.synced_folder ".", "/project"
    config.vm.provision :docker
    config.vm.provision "shell", path: "provision.sh"

end
