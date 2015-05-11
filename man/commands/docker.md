#### Docker

##### Configuration on Mac OSX 

    boot2docker init
    boot2docker up

    export DOCKER_HOST="tcp://0.0.0.0:2375"
    export DOCKER_TLS_VERIFY=1
    export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm

    echo $(boot2docker ip 2> /dev/null) dockerhost | sudo tee -a /etc/hosts

##### Usage

    docker info
    docker images
    docker search <term>
    docker pull <image>:<version>
    docker run -i -t --name=<name> <image>:<version> /bin/bash
    docker ps -a
    docker start <name>
    docker attach <name>
    docker stop <name>
    docker rm <name>
