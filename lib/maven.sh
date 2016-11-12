#!/bin/bash

print_h2 "Maven"

if [ $DIST = "ubuntu" ]; then
    ver=$(www_get https://maven.apache.org/download.cgi | grep 'bin.tar.gz' | egrep -o '[0-9]+\.[0-9]+\.[0-9]+' | sortvr | head -n 1)
    file_download \
        --url "http://mirrors.ukfast.co.uk/sites/ftp.apache.org/maven/maven-3/$ver/binaries/apache-maven-$ver-bin.tar.gz" \
        --file "apache-maven-$ver-bin.tar.gz"
    tar -zxf apache-maven-$ver-bin.tar.gz
    rm -rf $DIR/usr/applications/maven
    mv apache-maven-$ver $DIR/usr/applications/maven
    rm apache-maven-$ver-bin.tar.gz
fi
