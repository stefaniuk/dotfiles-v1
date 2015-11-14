#!/bin/bash

DEBIAN_FRONTEND="noninteractive"
apt_get_install="sudo apt-get --yes --force-yes --ignore-missing --no-install-recommends install"

################################################################################
# update

if [ -n "$arg_update_packages" ]; then
    print_h2 "Update packages"
    sudo apt-get --yes update
fi
if [ -n "$arg_update_system" ]; then
    print_h2 "Update OS"
    sudo apt-get --yes --force-yes upgrade
    sudo apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy dist-upgrade
fi

################################################################################
# install basic tools

if [ -n "$arg_install" ]; then
    print_h2 "Install basic tools"
    $apt_get_install \
        ack-grep \
        bash \
        bash-completion \
        curl \
        debconf-utils \
        expect \
        git \
        git-flow \
        grc \
        irssi \
        lynx \
        mc \
        pcregrep \
        python-pygments \
        ruby \
        tmux \
        tree \
        unzip \
        vim \
        wget \
        zsh
fi

################################################################################
# install server tools

if [ -n "$arg_install_server_tools" ] && [ -z "$arg_install_workstation_tools" ]; then
    print_h2 "Install server tools"
    $apt_get_install \
        heirloom-mailx \
        sendmail
fi

################################################################################
# install workstation tools

if [ -n "$arg_install_workstation_tools" ] && [ -z "$arg_install_server_tools" ]; then
    print_h2 "Install workstation tools"
    # compiz
    $apt_get_install \
        compiz \
        compizconfig-settings-manager \
        compiz-plugins-default \
        compiz-plugins
    # conky
    sudo add-apt-repository --yes ppa:teejee2008/ppa
    sudo apt-get update
    $apt_get_install \
        conky conky-manager \
        lm-sensors \
        hddtemp
    # others
    $apt_get_install \
        gtypist
fi

################################################################################
# install build tools

if [ -n "$arg_install_build_tools" ]; then
    print_h2 "Install build tools"
    $apt_get_install \
        binutils \
        build-essential \
        cmake \
        coreutils \
        gettext \
        libbz2-dev \
        libexpat1-dev \
        libglib2.0-dev \
        libicu-dev \
        libjpeg-dev \
        libmcrypt-dev \
        libpng12-dev \
        libslang2-dev \
        libssl-dev libcurl4-openssl-dev \
        libxml2-dev \
        ncurses-dev \
        zlib1g-dev
fi

################################################################################

sudo apt-get --yes --force-yes autoremove
sudo apt-get clean

exit 0
