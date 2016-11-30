#!/bin/bash

print_h2 "Compiz"

if [ $DIST = "ubuntu" ]; then
    $apt_get_install \
        compiz \
        compiz-plugins-default compiz-plugins \
        compizconfig-settings-manager
fi
