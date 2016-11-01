#!/bin/bash

if [ $DIST = "ubuntu" ]; then
    file_download \
        --url "https://vscode-update.azurewebsites.net/1.6.1/linux-deb-x64/stable" \
        --file "vscode-1.6.1.deb"
    sudo dpkg -i ./vscode-1.6.1.deb
    rm ./vscode-1.6.1.deb
fi

exit 0
