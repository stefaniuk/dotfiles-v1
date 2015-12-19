## Commands

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

    docker stop $(docker ps -a -q)
    docker inspect --format "{{ .NetworkSettings.IPAddress }}" <name>
    docker build -t <name>:<tag> --rm ./
