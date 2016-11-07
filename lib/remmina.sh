#!/bin/bash

print_h2 "Remmina"

if [ $DIST = "ubuntu" ]; then
    $apt_add_repository ppa:remmina-ppa-team/remmina-next
    $apt_get_update
    $apt_get_install \
        remmina \
        remmina-plugin-rdp \
        libfreerdp-plugins-standard
fi
