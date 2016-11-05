#!/bin/bash

print_h2 "VirtualBox"

if [ $DIST = "ubuntu" ]; then
    wget -q -O - http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | sudo apt-key add -
    sudo sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian $PSEUDO_NAME non-free contrib' > /etc/apt/sources.list.d/virtualbox.list"
    $apt_get_update
    $apt_get_install \
        virtualbox-5.1 \
        dkms
fi
