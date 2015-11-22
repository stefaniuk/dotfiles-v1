#!/bin/bash

apt_get_install="sudo apt-get --yes --ignore-missing --no-install-recommends install"
DEBIAN_FRONTEND="noninteractive"

################################################################################

if [ -n "$arg_install_system_tools" ]; then
    print_h2 "Install system tools"
    $apt_get_install \
        apt-file \
        apt-utils \
        debconf-utils \
        software-properties-common
fi

print_h2 "Install dotfiles tools"
$apt_get_install \
    bash-completion \
    bc \
    binutils \
    curl \
    expect \
    openssl \
    pcregrep \
    perl \
    python3 \
    rsync \
    sudo \
    unzip \
    wget \
    xz-utils

if [ -n "$arg_install_common_tools" ]; then
    print_h2 "Install common tools"
    $apt_get_install \
        ack-grep \
        grc \
        htop \
        lnav \
        mc \
        strace \
        traceroute \
        tree \
        vim \
        zsh
fi

if [ -n "$arg_install_server_tools" ]; then
    print_h2 "Install server tools"
    $apt_get_install \
        heirloom-mailx
fi

if [ -n "$arg_install_workstation_tools" ]; then
    print_h2 "Install workstation tools"
    $apt_get_install \
        git \
        git-flow \
        gtypist \
        irssi \
        lynx \
        openjdk-7-jdk \
        tmux
fi

################################################################################

sudo apt-get --yes autoremove
sudo apt-get clean

exit 0
