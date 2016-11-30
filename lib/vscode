#!/bin/bash

print_h2 "Visual Studio Code"

if [ $DIST = "ubuntu" ]; then
    ver=$(www_get https://code.visualstudio.com/updates | grep 'linux-deb-x64' | egrep -o '[0-9]+\.[0-9]+\.[0-9]+' | sortvr | head -n 1)
    file_download \
        --url "https://vscode-update.azurewebsites.net/$ver/linux-deb-x64/stable" \
        --file "vscode-$ver.deb"
    sudo dpkg -i vscode-$ver.deb
    rm vscode-$ver.deb
fi
