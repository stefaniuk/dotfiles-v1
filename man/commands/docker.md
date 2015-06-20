#### docker

##### configuration on Mac OSX

    boot2docker init
    boot2docker up

    export DOCKER_HOST="tcp://$(boot2docker ip):2375"
    export DOCKER_TLS_VERIFY=1
    export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
    echo $(boot2docker ip) dockerhost | sudo tee -a /etc/hosts

##### configuration on Linux

    # remove default docker0
    ip link set dev docker0 down
    brctl delbr docker0
    iptables -t nat -F POSTROUTING

    # create custom docker0
    brctl addbr docker0
    ip addr add 172.17.42.1/16 dev docker0
    ip link set dev docker0 up

    # starting docker (1) as a service
    service docker start
    # starting docker (2) manually
    docker -d \
        -H unix:///var/run/docker.sock \
        -H tcp://192.168.?.? \
        -D >> /var/log/docker.log 2>&1 &

    # start at boot
    systemctl enable docker
    # or
    chkconfig docker on

##### configuration file

    /etc/default/docker

##### configuration options

        DOCKER_OPTS= \
            --bip=172.17.0.1/24
            --log-level=debug

##### configuration variables

    export DOCKER_HOST="tcp://0.0.0.0:2375"

##### simple usage

    docker info
    docker images
    docker search <term>
    docker pull <image>:<version>
    docker create -i -t --name=<name> <image>:<version> /bin/bash
    docker run -i -t --name=<name> <image>:<version> /bin/bash
    docker ps -a
    docker start <name>
    docker inspect <name>
    docker top <name>
    docker logs -f <name>
    docker attach <name> # to exit press <ctrl+p> <ctrl+q>
    docker exec -i -t <name> bash -c <command>
    docker stop <name>
    docker rm <name>

##### advanced usage

    docker rm -v $(docker ps -a -q -f status=exited)                    # remove exited containers
    docker rmi $(docker images -f "dangling=true" -q)                   # remove unwanted images
    docker rmi $(docker images -a | awk '{ print $3 }' | grep -v IMAGE) # remove all images
    docker inspect --format "{{ .NetworkSettings.IPAddress }}" <name>
    docker build -t <name>:<tag> --rm ./
