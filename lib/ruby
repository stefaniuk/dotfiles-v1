#!/bin/bash

print_h2 "Ruby"

if [ $DIST = "ubuntu" ]; then
    $apt_get_install \
        ruby-full
    sudo gem install \
        rubygems-update
    sudo update_rubygems
    sudo gem update --system
fi
