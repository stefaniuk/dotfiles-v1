#!/bin/bash

# exit if script is sourced
[ -n "$BASH_SOURCE" ] && [ "$(basename -- "$0")" != "setup.sh" ] && exit 1

################################################################################
# variables

REPOSITORY="dotfiles"
GITHUB_ACCOUNT=${GITHUB_ACCOUNT-stefaniuk}
GITLAB_ACCOUNT=${GITLAB_ACCOUNT-stefaniuk}
USER_NAME=${USER_NAME-$USER}
USER_EMAIL=${USER_EMAIL-$USER@$HOSTNAME}

program_dir=$(cd "$(dirname "$0" 2> /dev/null)"; pwd)
arg_prepare=$(echo "$*" | grep -o -- "--prepare")
arg_update=$(echo "$*" | grep -o -- "--update")
arg_install=$(echo "$*" | grep -o -- "--install")
arg_install_system_tools=$(echo "$*" | grep -o -- "--install-system-tools")
arg_install_common_tools=$(echo "$*" | grep -o -- "--install-common-tools")
arg_install_server_tools=$(echo "$*" | grep -o -- "--install-server-tools")
arg_install_workstation_tools=$(echo "$*" | grep -o -- "--install-workstation-tools")
arg_config=$(echo "$*" | grep -o -- "--config")
arg_synchronise_only=$(echo "$*" | grep -o -- "--synchronise-only")
arg_force_download=$(echo "$*" | grep -o -- "--force-download")
arg_minimal=$(echo "$*" | grep -o -- "--minimal")
arg_sudo=$(echo "$*" | grep -o -- "--sudo")
arg_help=$(echo "$*" | grep -o -- "--help")

################################################################################
# functions

function usage {

    local file=$(basename $0 2> /dev/null)

    echo "
File: ${file}

Usage:
    ${file} [options]

Options:
    --prepare                       step (1)
    --update                        step (2)
    --install                       step (3)
    --install-system-tools
    --install-common-tools
    --install-server-tools
    --install-workstation-tools
    --config                        step (4)
    --synchronise-only              copy files to the user's directory only
    --force-download
    --minimal                       remove unnecessary project resources
    --sudo                          execute sudo-keep-alive
    --help
"

    exit 0
}

function sudo_keep_alive {

    # update user's time stamp, prompting for password if necessary
    sudo -v
    # keep-alive until script has finished then invalidate sudo session
    while true; do
        sudo -n true
        sleep 1
        if ! kill -0 "$$"; then
            sudo -k
            exit
        fi
    done 2>/dev/null &
}

function program_download {

    printf "Download $REPOSITORY\n\n"

    curl -L \
        "https://github.com/${GITHUB_ACCOUNT}/${REPOSITORY}/tarball/master" \
        -o ~/$REPOSITORY.tar.gz
    tar -zxf ~/$REPOSITORY.tar.gz -C ~
    rm -f ~/$REPOSITORY.tar.gz
    cp -rf ~/$GITHUB_ACCOUNT-$REPOSITORY-*/* ~
    rm -rf ~/$GITHUB_ACCOUNT-$REPOSITORY-*
    rm -rf ~/tmp/*
}

function program_synchronise {

    printf "Synchronise $REPOSITORY\n\n"

    rsync -rav \
        --include=/ \
        --exclude=/.git* \
        --exclude=.gitkeep \
        --exclude=Dockerfile* \
        --exclude=LICENCE \
        --exclude=Makefile \
        --exclude=provision.sh \
        --exclude=README.md \
        --exclude=Vagrantfile \
        $program_dir/* \
        ~

    printf "\n"
}

function program_setup {

    chmod 700 ~/{bin,lib,sbin,usr,usr/bin,test,test/bin,tmp}
    chmod 500 ~/{bin,usr/bin,test/bin}/*
    chmod 500 ~/setup.sh

    # detect operating system
    source ~/etc/bash/.bash_system
    # make available custom scripts
    export PATH=$PATH:~/bin:~/usr/bin

    # synchronise only
    [ -n "$arg_synchronise_only" ] && exit 0

    # check internet connection
    printf "Check internet connection\n"
    curl --silent --insecure --max-time 10 --retry 3 "https://google.com" > /dev/null
    if [[ $? -ne 0 ]]; then
        print_err "No internet connection"
    fi

    # check operating system
    printf "Check OS\n"
    if [ $DIST != "macosx" ] && [ $DIST != "ubuntu" ] && [ $DIST != "debian" ] && [ $DIST != "centos" ]; then
        print_err "Operating system is not fully supported"
    fi

    # prepare
    [ -n "$arg_prepare" ] && (. ~/sbin/prepare.sh $*)
    # install
    [ -n "$arg_install" ] && (. ~/sbin/install.sh $*)
    # config
    [ -n "$arg_config" ] && (. ~/sbin/config.sh $*)

    # remove not needed resources
    if [ -n "$arg_minimal" ]; then
        rm -rf ~/{etc,man,sbin,test,LICENCE*,README*,setup.sh}
    fi
    rm -rf ~/{.gitignore,Makefile,provision.sh,Vagrantfile}
    rm -rf ~/tmp/*
}

################################################################################
# main

[ -n "$arg_help" ] && usage
[ -n "$arg_sudo" ] && sudo_keep_alive

if [ -z "$BASH_SOURCE" ] || [ -n "$arg_force_download" ]; then

    # download from repository
    program_download

elif [[ $program_dir == */projects/$REPOSITORY ]] || [[ $program_dir == /project ]]; then

    # synchronise with project
    program_synchronise

fi

# perform post-install configuration
program_setup $*

exit 0
