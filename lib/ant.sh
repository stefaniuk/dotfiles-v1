#!/bin/bash

print_h2 "Ant"

if [ $DIST = "ubuntu" ]; then
    ver=$(www_get http://ant.apache.org/bindownload.cgi | grep 'bin.tar.gz' | egrep -o '[0-9]+\.[0-9]+\.[0-9]+' | sortvr | head -n 1)
    file_download \
        --url "http://mirrors.ukfast.co.uk/sites/ftp.apache.org//ant/binaries/apache-ant-$ver-bin.tar.gz" \
        --file "apache-ant-$ver-bin.tar.gz"
    tar -zxf apache-ant-$ver-bin.tar.gz
    rm -rf $DIR/usr/applications/ant
    mv apache-ant-$ver $DIR/usr/applications/ant
    rm apache-ant-$ver-bin.tar.gz
fi
