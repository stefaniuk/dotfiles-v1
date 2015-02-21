#!/bin/bash

########################################################################################################################
# install distribution specific components

if [ -z "$arg_install_common_only" ]; then

    print_h1 "Installing distribution specific components..."
    if [ -f ~/sbin/install.$DIST.sh ]; then
        (. ~/sbin/install.$DIST.sh $*)
    else
        print_err "File is missing"
    fi

fi

# install components
if [ "$DIST" == "macosx" ]; then

    if [ -n "$arg_update_system" ]; then
        print_h1 "Upgrading OS..."
        sudo softwareupdate --install -all
    fi
    if ! which brew > /dev/null; then
        print_h1 "Installing brew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew tap homebrew/dupes
    fi
    print_h1 "Installing components via brew..."
    brew install \
        ack \
        bash \
        bash-completion \
        curl \
        expect \
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
    if [ -n "$arg_update_packages" ]; then
        print_h1 "Updating packages..."
        brew upgrade
    fi
    if [ -n "$arg_install_build_dependencies" ]; then
        print_h1 "Installing build dependencies..."
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
            openssl \
            zlib \
            2> /dev/null
        brew link \
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
            openssl \
            zlib \
            --force \
            > /dev/null 2>&1
    fi
    brew linkapps > /dev/null

elif [ "$DIST" == "ubuntu" ]; then

    DEBIAN_FRONTEND="noninteractive"
    if [ -n "$arg_update_packages" ]; then
        print_h1 "Updating packages..."
        sudo apt-get --yes update
    fi
    if [ -n "$arg_update_system" ]; then
        print_h1 "Upgrading OS..."
        sudo apt-get --yes --force-yes upgrade
        sudo apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy dist-upgrade
    fi
    print_h1 "Installing components via apt-get..."
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
        screen \
        tmux \
        tree \
        unzip \
        vim \
        wget \
        zsh
    sudo apt-get --yes --force-yes autoremove
    sudo apt-get clean

    if [ -n "$arg_install_build_dependencies" ]; then
        print_h1 "Installing build dependencies..."
        sudo apt-get --yes --force-yes --ignore-missing --no-install-recommends install \
            binutils \
            build-essential \
            cmake \
            coreutils \
            libbz2-dev \
            libicu-dev \
            libjpeg-dev \
            libmcrypt-dev \
            libpng12-dev \
            libssl-dev libcurl4-openssl-dev \
            libxml2-dev \
            zlib1g-dev
        # libpcre3-dev libxpm-dev libfreetype6-dev libmysqlclient-dev libgd2-xpm-dev libgmp-dev libsasl2-dev libmhash-dev unixodbc-dev freetds-dev libpspell-dev libsnmp-dev libtidy-dev libxslt1-dev
    fi

fi

########################################################################################################################

print_h1 "Installing common components..."

################################################################################
# Oh My Zsh

print_h2 "Install Oh My Zsh"
if [ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
    rm -rf ~/{.oh-my-zsh,.zcompdump-*,.zlogin,.zsh*}
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
elif [ -d ~/.oh-my-zsh/.git ]; then
    (cd ~/.oh-my-zsh; git pull)
fi

########################################################################################################################
# test shell-* projects

if [ -z "$arg_do_not_run_tests" ]; then

    print_h1 "Testing shell-* projects..."

    # shell-commons
    print_h2 "\nshell-commons\n"
    $SHELL_COMMONS_HOME_DIR/sbin/run_tests $arg_skip_selected_tests
    result=$?
    [ -z "$arg_ignore_tests" ] && [ $result != 0 ] && exit $result

    # shell-utils
    print_h2 "shell-utils\n"
    $SHELL_UTILS_HOME_DIR/sbin/run_tests $arg_skip_selected_tests
    result=$?
    [ -z "$arg_ignore_tests" ] && [ $result != 0 ] && exit $result

    # shell-packages
    print_h2 "shell-packages\n"
    $SHELL_PACKAGES_HOME_DIR/sbin/run_tests $arg_skip_selected_tests
    result=$?
    [ -z "$arg_ignore_tests" ] && [ $result != 0 ] && exit $result

fi

########################################################################################################################
# clone repositories

if [ -n "$arg_clone_dev_repos" ]; then

    print_h1 "Installing repositories..."

    mkdir -p ~/projects

    # clone shell commons repository
    print_h2 "Clone shell-commons"
    if [ ! -d ~/projects/shell-commons ]; then
        git clone https://github.com/stefaniuk/shell-commons.git ~/projects/shell-commons
    else
        (cd ~/projects/shell-commons; git pull)
    fi

    # clone shell utils repository
    print_h2 "Clone shell-utils"
    if [ ! -d ~/projects/shell-utils ]; then
        git clone https://github.com/stefaniuk/shell-utils.git ~/projects/shell-utils
    else
        (cd ~/projects/shell-utils; git pull)
    fi

    # clone shell packages repository
    print_h2 "Clone shell-packages"
    if [ ! -d ~/projects/shell-packages ]; then
        git clone https://github.com/stefaniuk/shell-packages.git ~/projects/shell-packages
    else
        (cd ~/projects/shell-packages; git pull)
    fi

    # clone dotfiles repository
    print_h2 "Clone dotfiles"
    if [ ! -d ~/projects/dotfiles ]; then
        git clone https://github.com/stefaniuk/dotfiles.git ~/projects/dotfiles
    else
        (cd ~/projects/dotfiles; git pull)
    fi

fi

exit 0
