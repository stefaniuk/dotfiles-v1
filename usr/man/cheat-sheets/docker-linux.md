## Linux

TODO: check all

    # configuration file
    /etc/default/docker

    # configuration  variables
    DOCKER_OPTS=--bip=172.17.0.1/24 --log-level=debug
    DOCKER_HOST="tcp://0.0.0.0:2375"

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
