#!/bin/bash

print_h2 "Vagrant"

if [ $DIST = "ubuntu" ]; then
    ver=$(www_get https://www.vagrantup.com/downloads.html | grep 'x86_64.deb' | egrep '/[0-9]+\.[0-9]+\.[0-9]+' | egrep -o '[0-9]+\.[0-9]+\.[0-9]+' | sortvr | head -n 1)
    file_download \
        --url "https://releases.hashicorp.com/vagrant/$ver/vagrant_${ver}_x86_64.deb" \
        --file "vagrant_${ver}_x86_64.deb"
    sudo dpkg -i vagrant_${ver}_x86_64.deb
    rm vagrant_${ver}_x86_64.deb
fi