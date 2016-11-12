#!/bin/bash

print_h2 "Spring Tool Suite"

if [ $DIST = "ubuntu" ]; then
    ver_sts=$(www_get https://spring.io/tools/sts/all | grep 'linux-gtk-x86_64.tar.gz' | egrep -o '[0-9]+\.[0-9]+\.[0-9]+\.RELEASE' | sortvr | head -n 1)
    ver_ecl=$(www_get https://spring.io/tools/sts/all | grep 'linux-gtk-x86_64.tar.gz' | egrep -o 'e[0-9]+\.[0-9]+\.[0-9]+' | sortvr | head -n 1)
    file_download \
        --url "http://download.springsource.com/release/STS/${ver_sts}/dist/$(echo $ver_ecl | egrep -o 'e[0-9]+\.[0-9]+')/spring-tool-suite-${ver_sts}-${ver_ecl}-linux-gtk-x86_64.tar.gz" \
        --file "spring-tool-suite-${ver_sts}-${ver_ecl}-linux-gtk-x86_64.tar.gz"
    tar -zxf spring-tool-suite-${ver_sts}-${ver_ecl}-linux-gtk-x86_64.tar.gz
    rm -rf $DIR/usr/applications/spring-tool-suite
    mv -f sts-bundle $DIR/usr/applications/spring-tool-suite
    rm spring-tool-suite-${ver_sts}-${ver_ecl}-linux-gtk-x86_64.tar.gz
    cat <<EOF > ~/.local/share/applications/spring-tool-suite.desktop
[Desktop Entry]
Version=1.0
Name=Spring Tool Suite
Type=Application
Exec=$DIR/usr/applications/spring-tool-suite/sts-$ver_sts/STS
Icon=$DIR/usr/applications/spring-tool-suite/sts-$ver_sts/icon.xpm
Terminal=false
Categories=Utility;
EOF
fi
