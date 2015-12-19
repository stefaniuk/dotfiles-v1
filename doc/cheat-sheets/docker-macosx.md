## Mac OS X

    boot2docker init
    boot2docker up

    export DOCKER_HOST="tcp://$(boot2docker ip):2375"
    export DOCKER_TLS_VERIFY=1
    export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
    echo $(boot2docker ip) dockerhost | sudo tee -a /etc/hosts
