#!/bin/bash

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

if should_install "system-package"; then
    print_h2 "System tools"
    $apt_get_install \
        apt-file \
        apt-utils \
        ca-certificates \
        debconf-utils \
        locales \
        software-properties-common
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

    # Java 8
    $apt_add_repository ppa:webupd8team/java
    # Conky
    $apt_add_repository ppa:teejee2008/ppa
    # Sublime Text
    $apt_add_repository ppa:webupd8team/sublime-text-3
    # VirtualBox
    wget -q -O - http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | sudo apt-key add -
    sudo sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian $PSEUDO_NAME non-free contrib' > /etc/apt/sources.list.d/virtualbox.list"
    # Docker
    sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    sudo sh -c "echo 'deb https://apt.dockerproject.org/repo ubuntu-$PSEUDO_NAME main' > /etc/apt/sources.list.d/docker.list"
    # Chrome
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c "echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google-chrome.list"

    $apt_get_update

    # Java 8
    #echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
    #echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
    #$apt_get_install oracle-java8-installer
    #$apt_get_install oracle-java8-set-default
    # Compiz
    $apt_get_install compiz compizconfig-settings-manager compiz-plugins-default compiz-plugins
    # Conky
    $apt_get_install conky conky-manager lm-sensors hddtemp
    # Sublime Text
    $apt_get_install sublime-text-installer
    # VirtualBox
    $apt_get_install virtualbox-5.0
    # Vagrant
    $apt_get_install vagrant
    # Packer
    ver=$(www_get https://www.packer.io/downloads.html | grep '_linux_amd64.zip' | egrep '/[0-9]+\.[0-9+]\.[0-9]+' | egrep -o '[0-9]+\.[0-9+]\.[0-9]+' | sortvr | head -n 1)
    curl -SLO https://releases.hashicorp.com/packer/$ver/packer_${ver}_linux_amd64.zip
    sudo unzip -o packer_${ver}_linux_amd64.zip -d /usr/local/bin
    rm packer_${ver}_linux_amd64.zip
    # Docker
    $apt_get_install docker-engine
    ver=$(www_get https://github.com/docker/compose | grep '/docker/compose/tree/' | egrep '/[0-9]+\.[0-9+]\.[0-9]+"' | egrep -o '[0-9]+\.[0-9+]\.[0-9]+' | sortvr | head -n 1)
    sudo curl -SL https://github.com/docker/compose/releases/download/$ver/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    # Chrome
    $apt_get_install google-chrome-stable
fi

should_install "node"   && (. $DIR/lib/node.sh $*)
should_install "vscode" && (. $DIR/lib/vscode.sh $*)
should_install "ruby"   && (. $DIR/lib/ruby.sh $*)
