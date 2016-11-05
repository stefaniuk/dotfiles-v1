#!/bin/bash

print_h2 "Vagrant"

if [ $DIST = "ubuntu" ]; then
    $apt_get_install \
        vagrant
fi
