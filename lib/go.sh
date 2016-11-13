#!/bin/bash

print_h2 "Go"

if [ $DIST = "ubuntu" ]; then
    ver=$(www_get https://golang.org/dl/ | grep 'linux-amd64.tar.gz' | egrep -o '[0-9]+\.[0-9]+(\.[0-9]+)?' | sortvr | head -n 1)
    file_download \
        --url "https://storage.googleapis.com/golang/go${ver}.linux-amd64.tar.gz" \
        --file "go${ver}.linux-amd64.tar.gz"
    tar -zxf go${ver}.linux-amd64.tar.gz
    rm -rf $DIR/usr/applications/go
    mv go $DIR/usr/applications/go
    rm go${ver}.linux-amd64.tar.gz
fi