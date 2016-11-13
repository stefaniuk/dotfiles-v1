#!/bin/bash

print_h2 "SmartGit"

if [ $DIST = "ubuntu" ]; then
    ver=$(www_get http://www.syntevo.com/smartgit/download | grep '.tar.gz' | egrep -o '[0-9]+_[0-9]+_[0-9]+' | sortvr | head -n 1)
    file_download \
        --url "http://www.syntevo.com/static/smart/download/smartgit/smartgit-linux-$ver.tar.gz" \
        --file "smartgit-linux-$ver.tar.gz"
    tar -zxf smartgit-linux-$ver.tar.gz
    rm -rf $DIR/usr/applications/smartgit
    mv -f smartgit $DIR/usr/applications/smartgit
    rm smartgit-linux-$ver.tar.gz
    cat <<EOF > ~/.local/share/applications/smartgit.desktop
[Desktop Entry]
Version=1.0
Name=SmartGit
Type=Application
Exec=$DIR/usr/applications/smartgit/bin/smartgit.sh
Icon=$DIR/usr/applications/smartgit/bin/smartgit-64.png
Terminal=false
Categories=Utility;
EOF
fi