#!/bin/bash

cd $(dirname $BASH_SOURCE)

################################################################################
# variables                                                                    #
################################################################################

[ -z "$USER_NAME" ] && USER_NAME="Daniel Stefaniuk"
[ -z "$USER_EMAIL" ] && USER_EMAIL="daniel.stefaniuk@gmail.com"

################################################################################
# functions                                                                    #
################################################################################

function print_title() {
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
# main                                                                         #
################################################################################

# check system
if ([ ! -f /etc/debian_version ] || [ $(cat /etc/os-release | grep "^ID=" | awk -F= '{ print $2 }') != "ubuntu" ]) && [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "System not supported"
    exit 1
fi

# check connection
wget --quiet --timeout=10 --tries=3 --spider "https://google.com"
if [[ $? -ne 0 ]]; then
    print_error "No internet connection"
    exit 2
fi

# install MintLeaf
[ -z "$MINTLEAF_HOME" ] && MINTLEAF_HOME=/usr/local/mintleaf
if [ ! -f $MINTLEAF_HOME/bin/bootstrap ]; then
    wget https://raw.githubusercontent.com/stefaniuk/mintleaf/master/src/bin/install.sh -O - | /bin/bash -s -- \
        --mintleaf
fi
if [ -f $MINTLEAF_HOME/bin/bootstrap ]; then
    source $MINTLEAF_HOME/bin/bootstrap
else
    print_error "Unable to install MintLeaf"
    exit 3
fi

# configure system
if [ "$DIST" == "ubuntu" ]; then
    (. ./config-ubuntu.sh)
elif [ "$DIST" == "macosx" ]; then
    (. ./config-osx.sh)
fi

################################################################################
# Git

print_title "Git"
# TODO: install git
GIT_AUTHOR_NAME="$USER_NAME"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="$USER_EMAIL"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
git config --global push.default simple

################################################################################
# shell

print_title "shell"
cp ./{.exports,.functions,.aliases} ~/
mkdir -p ~/bin/
cp ./bin/bootstrap ~/bin/
[ -f ~/.bash_profile ] && file_remove_str "\n# BEGIN: load dotfiles\n(.)*# END\n" ~/.bash_profile --multiline
cat << EOF >> ~/.bash_profile

# BEGIN: load dotfiles
source ~/bin/bootstrap
# END: load dotfiles
EOF

################################################################################

exit 0
