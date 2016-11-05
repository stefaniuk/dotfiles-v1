#!/bin/bash

print_h2 "NodeJS"

if [ $DIST = "ubuntu" ]; then
    curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
    $apt_get_install \
        nodejs
    sudo npm install -g jsontool
fi
