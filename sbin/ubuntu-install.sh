#!/bin/bash

if should_install "utils-package"; then
    print_h2 "Utils"
    $apt_get_install \
        apt-file \
        apt-transport-https \
        apt-utils \
        ca-certificates \
        debconf-utils \
        locales \
        software-properties-common
fi

if should_install "dependencies-package"; then
    print_h2 "Dependencies"
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
        python-pygments \
        rsync \
        unzip \
        wget \
        xz-utils
fi

if should_install "common-package"; then
    print_h2 "Common tools"
    $apt_get_install \
        ack-grep \
        grc \
        htop \
        lnav \
        mc \
        strace \
        traceroute \
        tree \
        vim
fi

if should_install "server-package"; then
    print_h2 "Server tools"
    $apt_get_install \
        heirloom-mailx
fi

if should_install "workstation-package"; then
    print_h2 "Workstation tools"
    $apt_get_install \
        git-flow \
        gpgv2 \
        gtypist \
        irssi \
        lynx \
        tmux \
        zsh

    # Conky
    $apt_add_repository ppa:teejee2008/ppa
    # Sublime Text
    $apt_add_repository ppa:webupd8team/sublime-text-3
    # VirtualBox
    wget -q -O - http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | sudo apt-key add -
    sudo sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian $PSEUDO_NAME non-free contrib' > /etc/apt/sources.list.d/virtualbox.list"
    # Chrome
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c "echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google-chrome.list"

    $apt_get_update

    # Compiz
    $apt_get_install compiz compizconfig-settings-manager compiz-plugins-default compiz-plugins
    # Conky
    $apt_get_install conky conky-manager lm-sensors hddtemp
    # Sublime Text
    $apt_get_install sublime-text-installer
    # VirtualBox
    $apt_get_install virtualbox-5.0
    # Chrome
    $apt_get_install google-chrome-stable
fi

should_install "java"       && (. $DIR/lib/java.sh $*)
should_install "node"       && (. $DIR/lib/node.sh $*)
should_install "vscode"     && (. $DIR/lib/vscode.sh $*)
should_install "ruby"       && (. $DIR/lib/ruby.sh $*)
should_install "docker"     && (. $DIR/lib/docker.sh $*)
should_install "packer"     && (. $DIR/lib/packer.sh $*)
should_install "vagrant"    && (. $DIR/lib/vagrant.sh $*)
