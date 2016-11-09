#!/bin/bash

print_h2 "Chrome"

if [ $DIST = "ubuntu" ]; then
    $apt_get_install \
        libappindicator1 \
        libindicator7
    file_download \
        --url "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" \
        --file "google-chrome-stable_current_amd64.deb"
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
fi
