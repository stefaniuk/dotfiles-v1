#!/bin/bash

################################################################################
# update

if [ -n "$arg_update_system" ]; then
    print_h2 "Update operating system"
    :
fi
if [ -n "$arg_update_packages" ]; then
    print_h2 "Update packages"
    :
fi

################################################################################
# install basic tools

if [ -n "$arg_install" ]; then
    print_h2 "Install basic tools"
    sudo yum --assumeyes install \
        ack \
        bash \
        bash-completion \
        bc \
        curl \
        expect \
        gcc \
        git \
        gitflow \
        irssi \
        lynx \
        mc \
        net-tools \
        patch \
        pcre \
        ruby \
        strace \
        tmux \
        tree \
        unzip \
        vim \
        wget \
        zsh
fi

################################################################################
# install build tools

if [ -n "$arg_install_build_tools" ]; then
    print_h2 "Install build tools"
    sudo yum --assumeyes install \
        curl-devel \
        gettext \
        glib2-devel \
        ncurses-devel \
        perl-CPAN \
        slang-devel \
        zlib-devel
fi

################################################################################
# install server tools

if [ -n "$arg_install_server_tools" ] && [ -z "$arg_install_workstation_tools" ]; then
    print_h2 "Install server tools"
    sudo yum --assumeyes install \
        m4 \
        mailx \
        sendmail
fi

################################################################################
# install workstation tools

if [ -n "$arg_install_workstation_tools" ] && [ -z "$arg_install_server_tools" ]; then
    print_h2 "Install workstation tools"
    :
fi

################################################################################

exit 0
