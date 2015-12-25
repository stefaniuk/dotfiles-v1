## Configuration

    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.synced_folder "/host/dir", "/guest/dir"
    config.vm.provision "shell", path: "script.sh"

## Commands

    vagrant box list
    vagrant box add ubuntu/trusty64
    vagrant init ubuntu/trusty64
    vagrant up

    vagrant box add your/box path/to/your/box/file.box
