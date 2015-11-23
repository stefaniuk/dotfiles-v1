#!/bin/bash

yum_install="sudo yum --assumeyes install"

################################################################################

print_h2 "Install dotfiles tools"
$yum_install \
    bash-completion \
    bc \
    curl \
    expect \
    git \
    openssl \
    pcre-tools \
    perl \
    python \
    rsync \
    sudo \
    unzip \
    wget \
    xz

if [ -n "$arg_install_common_tools" ]; then
    print_h2 "Install common tools"
    $yum_install \
        ack \
        htop \
        lnav \
        mc \
        strace \
        traceroute \
        tree \
        vim \
        zsh
        # MISSING: grc
fi

if [ -n "$arg_install_server_tools" ]; then
    print_h2 "Install server tools"
    $yum_install \
        mailx
fi

################################################################################

sudo yum clean packages

exit 0
