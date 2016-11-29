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

if should_install "system-bundle"; then
    print_h2 "System Bundle"
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

if should_install "admin-bundle"; then
    print_h2 "Admin Bundle"
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

if should_install "developer-bundle"; then
    print_h2 "Developer Bundle"
    $apt_get_install \
        byobu \
        git-flow \
        gpgv2 \
        gtypist \
        irssi \
        nfs-kernel-server \
        tmux \
        zsh
fi

if should_install "user-bundle"; then
    print_h2 "User Bundle"
fi

should_install "java"           && (. $DIR/lib/java.sh $*)
should_install "java-tools"     && (. $DIR/lib/java-tools.sh $*)
should_install "node"           && (. $DIR/lib/node.sh $*)
should_install "node-tools"     && (. $DIR/lib/node-tools.sh $*)
should_install "ruby"           && (. $DIR/lib/ruby.sh $*)
should_install "ruby-tools"     && (. $DIR/lib/ruby-tools.sh $*)

should_install "chrome"         && (. $DIR/lib/chrome.sh $*)
should_install "compiz"         && (. $DIR/lib/compiz.sh $*)
should_install "directory"      && (. $DIR/lib/directory.sh $*)
should_install "docker"         && (. $DIR/lib/docker.sh $*)
should_install "emacs"          && (. $DIR/lib/emacs.sh $*)
should_install "go"             && (. $DIR/lib/go.sh $*)
should_install "packer"         && (. $DIR/lib/packer.sh $*)
should_install "pgadmin"        && (. $DIR/lib/pgadmin.sh $*)
should_install "remmina"        && (. $DIR/lib/remmina.sh $*)
should_install "smartgit"       && (. $DIR/lib/smartgit.sh $*)
should_install "sts"            && (. $DIR/lib/sts.sh $*)
should_install "subl"           && (. $DIR/lib/subl.sh $*)
should_install "vagrant"        && (. $DIR/lib/vagrant.sh $*)
should_install "virtualbox"     && (. $DIR/lib/virtualbox.sh $*)
should_install "vscode"         && (. $DIR/lib/vscode.sh $*)
