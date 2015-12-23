#!/bin/bash

yum_install="sudo yum --assumeyes install"

################################################################################

if [ -n "$arg_update" ]; then

    sudo yum --assumeyes update
    $yum_install epel-release

fi

################################################################################

print_h2 "Install dotfiles tools"
$yum_install \
    bash-completion \
    bc \
    curl \
    expect \
    git \
    openssl \
    pcre \
    perl \
    python \
    rsync \
    sudo \
    unzip \
    wget \
    xz

if should_install "common"; then
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

if should_install "server"; then
    print_h2 "Install server tools"
    $yum_install \
        mailx
fi

################################################################################

sudo yum clean packages

exit 0
