#!/bin/bash

print_h1 "Installing optional components..."

################################################################################
# install custom packages

print_h2 "Install components via spkg"
spkg install \
    git \
    vim mc \
    jdk maven gradle groovy spring \
    mysql \
    apr apr-util pcre httpd pcre php \
    node \
    --patch --configure --global

print_h2 "Install components via npm"
sudo npm install -g grunt-cli
sudo npm install -g bower
sudo npm install -g yo

################################################################################

exit 0
