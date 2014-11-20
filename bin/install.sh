#!/bin/bash

################################################################################
# exports                                                                      #
################################################################################

export GITHUB_REPOSITORY_ACCOUNT="stefaniuk"
export GITHUB_REPOSITORY_NAME="dotfiles"
[ -z "$USER_NAME" ] && export USER_NAME="Daniel Stefaniuk"
[ -z "$USER_EMAIL" ] && export USER_EMAIL="daniel.stefaniuk@gmail.com"
#[ -z "$COMP_NAME" ] && export COMP_NAME="comp"

################################################################################
# functions                                                                    #
################################################################################

# `readlink -f` alternative
function abspath() { pushd . > /dev/null; if [ -d "$1" ]; then cd "$1"; dirs -l +0; else cd "`dirname \"$1\"`"; cur_dir=`dirs -l +0`; if [ "$cur_dir" == "/" ]; then echo "$cur_dir`basename \"$1\"`"; else echo "$cur_dir/`basename \"$1\"`"; fi; fi; popd > /dev/null; }

function print_progress() {
    tput bold
    echo "$1"
    tput sgr 0
}

function print_title() {
    tput setaf 4
    tput bold
    echo "$1"
    tput sgr 0
}

function print_info() {
    tput setaf 3
    echo "    $1"
    tput sgr 0
}

function print_error() {
    tput setaf 1
    echo "$1"
    echo
    tput sgr 0
}

################################################################################
# download                                                                     #
################################################################################

cd $(dirname $(dirname $(abspath $0)))
if [ ! -f ./bin/install.sh ] || [ ! -f ./bin/config-common ]; then

    print_progress "Downloading dotfiles..."

    dir=/tmp/dotfiles-$RANDOM

    rm -rf $dir
    mkdir -p $dir
    wget -O $dir/$GITHUB_REPOSITORY_NAME.tar.gz "https://github.com/$GITHUB_REPOSITORY_ACCOUNT/$GITHUB_REPOSITORY_NAME/tarball/master"
    tar zxf $dir/$GITHUB_REPOSITORY_NAME.tar.gz -C $dir
    cd $(ls -d -1 $dir/$GITHUB_REPOSITORY_ACCOUNT-$GITHUB_REPOSITORY_NAME-*)

    chmod +x ./bin/install.sh
    ./bin/install.sh $*
    result=$?
    rm -rf $dir
    exit $result

fi

################################################################################
# arguments                                                                    #
################################################################################

args=$*
arg_force_mintleaf=$(echo "$args" | grep -- "--force-mintleaf" | wc -l)
arg_force_oh_my_zsh=$(echo "$args" | grep -- "--force-oh-my-zsh" | wc -l)

################################################################################
# main                                                                         #
################################################################################

# update the user's cached credentials, authenticating the user if necessary
sudo -v
# keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# check operating system
print_progress "Checking OS..."
if ([ ! -f /etc/debian_version ] || [ $(cat /etc/os-release | grep "^ID=" | awk -F= '{ print $2 }') != "ubuntu" ]) && [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "Operating system not supported"
    exit 1
fi

# check internet connection
print_progress "Checking internet connection..."
wget --quiet --timeout=10 --tries=3 --spider "https://google.com"
if [[ $? -ne 0 ]]; then
    print_error "No internet connection"
    exit 2
fi

# install MintLeaf
[ -z "$MINTLEAF_HOME" ] && MINTLEAF_HOME=/usr/local/mintleaf
if [ ! -f $MINTLEAF_HOME/bin/bootstrap ] || [ $arg_force_mintleaf -gt 0 ]; then
    print_progress "Installing MintLeaf..."
    wget https://raw.githubusercontent.com/stefaniuk/mintleaf/master/src/bin/install.sh -O - | /bin/bash -s -- \
        --mintleaf \
        --git
fi
if [ -f $MINTLEAF_HOME/bin/bootstrap ]; then
    source $MINTLEAF_HOME/bin/bootstrap
else
    print_error "MintLeaf is missing"
    exit 3
fi

# install Oh My Zsh
if [ ! -d ~/.oh-my-zsh ] || [ $arg_force_oh_my_zsh -gt 0 ]; then
    print_progress "Installing Oh My Zsh..."
    rm -rf ~/{.oh-my-zsh,.zcompdump-*,.zlogin,.zsh*}
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    #sudo chsh -s /bin/zsh $USER
fi
if [ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
    print_error "Oh My Zsh is missing"
    exit 4
fi

# install and configure system components
if [ "$DIST" == "ubuntu" ]; then

    #print_progress "Installing system components..."
    #(. $MINTLEAF_HOME/bin/install.sh \
    #    ?
    #)
    #[ $? != 0 ] && exit 5

    print_progress "Configuring common system components..."
    (. ./bin/config-common)
    [ $? != 0 ] && exit 6

    print_progress "Configuring system specific components..."
    (. ./bin/config-ubuntu)
    [ $? != 0 ] && exit 7

elif [ "$DIST" == "macosx" ]; then

    print_progress "Installing system components..."
    (. $MINTLEAF_HOME/bin/install.sh \
        --groovy \
        --java8 \
        --nodejs \
        --packer \
        --ruby \
        --spring-cli \
        --vagrant \
        --virtualbox
    )
    [ $? != 0 ] && exit 5

    print_progress "Configuring common system components..."
    (. ./bin/config-common)
    [ $? != 0 ] && exit 6

    print_progress "Configuring system specific components..."
    (. ./bin/config-macosx)
    [ $? != 0 ] && exit 7

fi

################################################################################

exit 0
