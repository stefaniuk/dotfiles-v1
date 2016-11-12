#!/bin/bash

print_h2 "Docker"

if [ $DIST = "ubuntu" ]; then
    sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    sudo sh -c "echo 'deb http://apt.dockerproject.org/repo ubuntu-$PSEUDO_NAME main' > /etc/apt/sources.list.d/docker.list"
    $apt_get_update
    $apt_get_install \
        docker-engine
    ver=$(www_get https://github.com/docker/compose | grep '/docker/compose/tree/' | egrep '/[0-9]+\.[0-9]+\.[0-9]+"' | egrep -o '[0-9]+\.[0-9]+\.[0-9]+' | sortvr | head -n 1)
    sudo curl -SL https://github.com/docker/compose/releases/download/$ver/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi
