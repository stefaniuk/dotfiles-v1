## Commands

#### simple usage

    docker info

    docker images
    docker search <term>
    docker pull <image>:<tag>
    docker rmi <image>:<tag>

    docker create -it --name=<name> <image>:<tag> <command>
    docker run -d -it --name=<name> <image>:<tag> <command>

    docker ps -a
    docker start <name>
    docker top <name>
    docker logs -f <name> # ctrl+c
    docker exec -it <name> bash -c <command>
    docker attach <name> # ctrl+p,ctrl+q
    docker stop <name>
    docker rm <name>

#### advanced usage

    docker build -t <name>:<tag> --rm .

    docker inspect --format "{{ .NetworkSettings.IPAddress }}" <name>

    docker login --username=username --email=email
