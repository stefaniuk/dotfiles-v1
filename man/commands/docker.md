#### Docker

##### Configuration on Mac OSX

    boot2docker init
    boot2docker up

    export DOCKER_HOST="tcp://$(boot2docker ip):2375"
    export DOCKER_TLS_VERIFY=1
    export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
    echo $(boot2docker ip) dockerhost | sudo tee -a /etc/hosts

##### Configuration on Linux

    docker -d \
        -H unix:///var/run/docker.sock \
        -H tcp://192.168.?.? \
        -D >> /var/log/docker.log 2>&1 &

    export DOCKER_HOST="tcp://0.0.0.0:2375"

##### Usage

    docker info
    docker images
    docker search <term>
    docker pull <image>:<version>
    docker create -i -t --name=<name> <image>:<version> /bin/bash
    docker run -i -t --name=<name> <image>:<version> /bin/bash
    docker ps -a
    docker start <name>
    docker attach <name> # to exit press <ctrl+p> <ctrl+q>
    docker stop <name>
    docker rm <name>
