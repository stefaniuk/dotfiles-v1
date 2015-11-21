#!/bin/bash

yum_install="sudo yum --assumeyes install"

################################################################################

if [ -n "$arg_install_system_tools" ]; then
    print_h2 "Install system tools"
    #$yum_install
fi

print_h2 "Install dotfiles tools"
$yum_install \
    bash-completion \
    bc \
    curl \
    expect \
    openssl \
    pcre-tools \
    perl \
    python python34 \
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
        patch \
        strace \
        traceroute \
        tree \
        vim \
        zsh
        # grc
fi

if [ -n "$arg_install_server_tools" ]; then
    print_h2 "Install server tools"
    $yum_install \
        mailx
fi

if [ -n "$arg_install_workstation_tools" ]; then
    print_h2 "Install workstation tools"
    $yum_install \
        git \
        gitflow \
        gtypist \
        irssi \
        java-1.7.0-openjdk \
        lynx \
        tmux
fi

################################################################################

sudo yum clean all

exit 0
