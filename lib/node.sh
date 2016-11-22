#!/bin/bash

print_h2 "NodeJS"

if [ $DIST = "ubuntu" ]; then
    curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
    $apt_get_install \
        nodejs
    sudo chown -R $(whoami) /usr/lib/node_modules
    npm update -g
    npm install -g \
        json
fi
