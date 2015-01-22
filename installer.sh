#!/bin/bash

# exit if script is sourced
[ -n "$BASH_SOURCE" ] && [ "$(basename -- "$0")" != "installer.sh" ] && exit 1

################################################################################
# variables

GITHUB_REPOSITORY_ACCOUNT="stefaniuk"
GITHUB_REPOSITORY_NAME="dotfiles"
USER_NAME=${USER_NAME-"Daniel Stefaniuk"}
USER_EMAIL=${USER_EMAIL-"daniel.stefaniuk@gmail.com"}
program_dir=$(cd "$(dirname "$0" 2> /dev/null)"; pwd)

################################################################################
# functions

function program_download {

    printf "Download...\n\n"

    wget \
        -O ~/$GITHUB_REPOSITORY_NAME.tar.gz \
        "https://github.com/${GITHUB_REPOSITORY_ACCOUNT}/${GITHUB_REPOSITORY_NAME}/tarball/master"
    tar -zxf ~/$GITHUB_REPOSITORY_NAME.tar.gz -C ~
    rm -f ~/$GITHUB_REPOSITORY_NAME.tar.gz
    cp -rf ~/$GITHUB_REPOSITORY_ACCOUNT-$GITHUB_REPOSITORY_NAME-*/* ~
    rm -rf ~/$GITHUB_REPOSITORY_ACCOUNT-$GITHUB_REPOSITORY_NAME-*
}

function program_synchronise {

    printf "Synchronise...\n\n"

    rsync -rav --include=/ --exclude=/.git* \
        $program_dir/. \
        ~

    printf "\n"
}

function program_configure {

    chmod +x ~/installer.sh
    chmod +x ~/bin/*
    chmod +x ~/sbin/run_config
}

################################################################################
# main

if [ -z "$BASH_SOURCE" ]; then

    # download from repository
    program_download

elif [[ $program_dir == */projects/$GITHUB_REPOSITORY_NAME ]]; then

    # synchronise with project
    program_synchronise

fi

# perform post-install configuration
program_configure
# run config
~/sbin/run_config
exit $?
