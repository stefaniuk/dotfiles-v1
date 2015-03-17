#### vagrant

##### cli

    vagrant box add ubuntu/trusty64
    vagrant box list
    vagrant init ubuntu/trusty64
    vagrant up

##### config

    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.synced_folder "/host/dir", "/guest/dir"
    config.vm.provision "shell", path: "script.sh"
