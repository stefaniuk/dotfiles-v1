#!/bin/bash

print_h2 "Java"

if [ $DIST = "ubuntu" ]; then
    $apt_add_repository ppa:webupd8team/java
    $apt_get_update
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
    $apt_get_install \
        oracle-java9-installer \
        oracle-java9-set-default
fi
