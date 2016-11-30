#!/bin/bash

print_h2 "VirtualBox"

if [ $DIST = "ubuntu" ]; then
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
    sudo sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian $PSEUDO_NAME contrib' > /etc/apt/sources.list.d/virtualbox.list"
    $apt_get_update
    $apt_get_install \
        virtualbox-5.1
fi
