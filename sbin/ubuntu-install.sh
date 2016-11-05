#!/bin/bash

if should_install "dependencies"; then
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

if should_install "utils-package"; then
    print_h2 "Utils Package"
    $apt_get_install \
        apt-file \
        apt-transport-https \
        apt-utils \
        ca-certificates \
        debconf-utils \
        dialog \
        locales \
        software-properties-common
fi

if should_install "tools-package"; then
    print_h2 "Tools Package"
    $apt_get_install \
        ack-grep \
        grc \
        heirloom-mailx \
        htop \
        iputils-ping \
        lnav \
        lsof \
        lynx \
        mc \
        net-tools \
        netcat \
        strace \
        traceroute \
        tree \
        vim
fi

if should_install "workstation-package"; then
    print_h2 "Workstation Package"
    $apt_get_install \
        git-flow \
        gpgv2 \
        gtypist \
        irssi \
        tmux \
        zsh
fi

    # Conky
    #$apt_add_repository ppa:teejee2008/ppa
    # Sublime Text
    #$apt_add_repository ppa:webupd8team/sublime-text-3
    # Chrome
    #wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    #sudo sh -c "echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google-chrome.list"

    #$apt_get_update

    # Compiz
    #$apt_get_install compiz compizconfig-settings-manager compiz-plugins-default compiz-plugins
    # Conky
    #$apt_get_install conky conky-manager lm-sensors hddtemp
    # Sublime Text
    #$apt_get_install sublime-text-installer
    # Chrome
    #$apt_get_install google-chrome-stable

should_install "java"       && (. $DIR/lib/java.sh $*)
should_install "node"       && (. $DIR/lib/node.sh $*)
should_install "vscode"     && (. $DIR/lib/vscode.sh $*)
should_install "ruby"       && (. $DIR/lib/ruby.sh $*)
should_install "docker"     && (. $DIR/lib/docker.sh $*)
should_install "virtualbox" && (. $DIR/lib/virtualbox.sh $*)
should_install "vagrant"    && (. $DIR/lib/vagrant.sh $*)
should_install "packer"     && (. $DIR/lib/packer.sh $*)
