#!/bin/bash

print_h2 "Apache Directory Studio"

if [ $DIST = "ubuntu" ]; then
    ver=$(www_get https://directory.apache.org/studio/download/download-linux.html | grep 'linux.gtk.x86_64.tar.gz' | egrep -o '[0-9]+\.[0-9]+\.[0-9]+\.v[0-9]+-M[0-9]+' | sortvr | head -n 1)
    file_download \
        --url "http://mirrors.ukfast.co.uk/sites/ftp.apache.org/directory/studio/${ver}/ApacheDirectoryStudio-${ver}-linux.gtk.x86_64.tar.gz" \
        --file "ApacheDirectoryStudio-${ver}-linux.gtk.x86_64.tar.gz"
    tar -zxf ApacheDirectoryStudio-${ver}-linux.gtk.x86_64.tar.gz
    rm -rf $DIR/usr/applications/apache-directory-studio
    mv -f ApacheDirectoryStudio $DIR/usr/applications/apache-directory-studio
    rm ApacheDirectoryStudio-${ver}-linux.gtk.x86_64.tar.gz
    cat <<EOF > ~/.local/share/applications/apache-directory-studio.desktop
[Desktop Entry]
Version=1.0
Name=Apache Directory Studio
Type=Application
Exec=$DIR/usr/applications/apache-directory-studio/ApacheDirectoryStudio
Icon=$DIR/usr/applications/apache-directory-studio/icon.xpm
Terminal=false
Categories=Utility;
EOF
fi
