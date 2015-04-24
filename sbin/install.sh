#!/bin/bash

print_h1 "Installing required components..."

################################################################################
# install basic dependencies

if [ $DIST == "macosx" ]; then

    if ! which brew > /dev/null; then
        print_h2 "Install brew"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    if [ -n "$arg_update_system" ]; then
        print_h2 "Update OS"
        sudo softwareupdate --install -all
    fi
    if [ -n "$arg_update_packages" ]; then
        print_h2 "Update packages"
        brew tap homebrew/dupes 2> /dev/null
        brew update
        brew upgrade
    fi
    print_h2 "Install components via brew"
    brew install \
        ack \
        bash \
        bash-completion \
        caskroom/cask/brew-cask \
        curl \
        git \
        grc \
        irssi \
        lynx \
        mc \
        pcre \
        screen \
        tmux \
        tree \
        unzip \
        vim \
        wget \
        zsh \
        2> /dev/null
    brew linkapps > /dev/null

elif [ $DIST == "ubuntu" ]; then

    DEBIAN_FRONTEND="noninteractive"
    if [ -n "$arg_update_packages" ]; then
        print_h2 "Update packages"
        sudo apt-get --yes update
    fi
    if [ -n "$arg_update_system" ]; then
        print_h2 "Update OS"
        sudo apt-get --yes --force-yes upgrade
        sudo apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy dist-upgrade
    fi
    print_h2 "Install components via apt-get"
    sudo apt-get --yes --force-yes --ignore-missing --no-install-recommends install \
        ack-grep \
        bash \
        bash-completion \
        curl \
        debconf-utils \
        expect \
        git \
        grc \
        irssi \
        lynx \
        mc \
        pcregrep \
        ruby \
        screen \
        tmux \
        tree \
        unzip \
        vim \
        wget \
        zsh
    sudo apt-get --yes --force-yes autoremove
    sudo apt-get clean

elif [ $DIST == "scientific" ]; then

    print_h2 "Install components via yum"
    sudo yum --assumeyes install \
        ack \
        bash \
        bash-completion \
        bc \
        curl \
        expect \
        gcc \
        git \
        irssi \
        lynx \
        mc \
        net-tools \
        patch \
        pcre \
        ruby \
        screen \
        strace \
        tmux \
        tree \
        unzip \
        vim \
        wget \
        zsh

fi

################################################################################
# install build dependencies

if [ $DIST == "macosx" ] && [ -n "$arg_install_build_dependencies" ]; then

    print_h2 "Install build dependencies via brew"
    brew install \
        binutils \
        bzip2 \
        cmake \
        coreutils \
        curl \
        gcc \
        gettext \
        icu4c \
        libiconv \
        makedepend \
        mcrypt \
        ncurses \
        openssl \
        zlib \
        2> /dev/null
    brew link --overwrite --force \
        binutils \
        bzip2 \
        cmake \
        coreutils \
        curl \
        gcc \
        gettext \
        icu4c \
        libiconv \
        makedepend \
        mcrypt \
        ncurses \
        openssl \
        zlib \
        > /dev/null 2>&1
    brew linkapps > /dev/null

elif [ $DIST == "ubuntu" ] && [ -n "$arg_install_build_dependencies" ]; then

    print_h2 "Install build dependencies via apt-get"
    DEBIAN_FRONTEND="noninteractive"
    sudo apt-get --yes --force-yes --ignore-missing --no-install-recommends install \
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
    sudo apt-get --yes --force-yes autoremove
    sudo apt-get clean

elif [ $DIST == "scientific" ] && [ -n "$arg_install_build_dependencies" ]; then

    print_h2 "Install build dependencies via yum"
    sudo yum --assumeyes install \
        curl-devel \
        gettext \
        glib2-devel \
        ncurses-devel \
        slang-devel \
        zlib-devel

fi

################################################################################
# Oh My Zsh

print_h2 "Install Oh My Zsh"
if [ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
    rm -rf ~/{.oh-my-zsh,.zcompdump-*,.zlogin,.zsh*}
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
elif [ -d ~/.oh-my-zsh/.git ]; then
    (cd ~/.oh-my-zsh; git pull)
fi

################################################################################
# Tmuxinator

print_h2 "Install Tmuxinator"
sudo gem install tmuxinator

################################################################################

exit 0
