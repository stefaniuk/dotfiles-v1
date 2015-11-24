#!/bin/bash

apt_get_update="sudo apt-get --yes update"
apt_get_install="sudo apt-get --yes --ignore-missing --no-install-recommends install"
apt_add_repository="sudo add-apt-repository --yes"
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
    git \
    openssl \
    pcregrep \
    perl \
    python \
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
        git-flow \
        gtypist \
        irssi \
        lynx \
        openjdk-7-jdk \
        tmux

    # compiz
    $apt_get_install \
        compiz \
        compizconfig-settings-manager \
        compiz-plugins-default \
        compiz-plugins
    # conky
    $apt_add_repository ppa:teejee2008/ppa
    $apt_get_update
    $apt_get_install \
        conky \
        conky-manager \
        lm-sensors hddtemp
    # sublime text
    $apt_add_repository ppa:webupd8team/sublime-text-3
    $apt_get_update
    $apt_get_install \
        sublime-text-installer
    # virtualbox
    wget -q -O - http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | sudo apt-key add -
    sudo sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian $PSEUDO_NAME non-free contrib' > /etc/apt/sources.list.d/virtualbox.list"
    $apt_get_update
    $apt_get_install \
        virtualbox-5.0
    # vagrant
    $apt_get_install \
        vagrant
    # docker
    sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    sudo sh -c "echo 'deb https://apt.dockerproject.org/repo ubuntu-$PSEUDO_NAME main' > /etc/apt/sources.list.d/docker.list"
    $apt_get_update
    $apt_get_install \
        docker-engine
    ver=$(www_get https://github.com/docker/compose | grep '/docker/compose/tree/' | egrep '/[0-9]+\.[0-9+]\.[0-9]+"' | egrep -o '[0-9]+\.[0-9+]\.[0-9]+' | sortvr | head -n 1)
    sudo curl -L https://github.com/docker/compose/releases/download/$ver/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    # chrome
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c "echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google-chrome.list"
    $apt_get_update
    $apt_get_install \
        google-chrome-stable
fi

################################################################################

sudo apt-get --yes autoremove
sudo apt-get clean

exit 0
