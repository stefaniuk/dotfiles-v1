#!/bin/bash

# exit if script is sourced
[ -n "$BASH_SOURCE" ] && [ "$(basename -- "$0")" != "setup.sh" ] && exit 1

################################################################################
# variables

REPOSITORY="dotfiles"
GITHUB_ACCOUNT=${GITHUB_ACCOUNT-stefaniuk}
BITBUCKET_ACCOUNT=${BITBUCKET_ACCOUNT-stefaniuk}
GITLAB_ACCOUNT=${GITLAB_ACCOUNT-stefaniuk}
USER_NAME=${USER_NAME-Daniel Stefaniuk}
USER_EMAIL=${USER_EMAIL-daniel.stefaniuk@gmail.com}
DIR=~

program_dir=$(cd "$(dirname "$0" 2> /dev/null)"; pwd)
arg_prepare=$(echo "$*" | grep -o -- "--prepare")
arg_install=$(echo "$*" | grep -o -- "--install")
arg_config=$(echo "$*" | grep -o -- "--config")
arg_update=$(echo "$*" | grep -o -- "--update")
arg_test=$(echo "$*" | grep -o -- "--test")
arg_synchronise_only=$(echo "$*" | grep -o -- "--synchronise-only")
arg_force_download=$(echo "$*" | grep -o -- "--force-download")
arg_directory=$(echo "$*" | grep -Eo -- "--directory [-_A-Za-z0-9/]+" | awk '{print $2}')
arg_minimal=$(echo "$*" | grep -o -- "--minimal")
arg_sudo=$(echo "$*" | grep -o -- "--sudo")
arg_help=$(echo "$*" | grep -o -- "--help")

arg_install_groups=$(echo "$*" | grep -o -- "--install=[-_,A-Za-z0-9]*" | sed "s/--install=//")
arg_config_progs=$(echo "$*" | grep -o -- "--config=[-_,A-Za-z0-9]*" | sed "s/--config=//")
arg_update_progs=$(echo "$*" | grep -o -- "--update=[-_,A-Za-z0-9]*" | sed "s/--update=//")

################################################################################
# functions

function usage {

    local file=$(basename $0 2> /dev/null)

    echo "
File: ${file}

Usage:
    ${file} [options]

Options:
    --prepare
    --install[=system,common,server,workstation[,prog1,prog2,...]]
    --config[=prog1,prog2,...]
    --update[=prog1,prog2,...]
    --test
    --synchronise-only              copy files only
    --force-download
    --directory                     installation directory
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
        -o $DIR/$REPOSITORY.tar.gz
    tar -zxf $DIR/$REPOSITORY.tar.gz -C $DIR
    rm -f $DIR/$REPOSITORY.tar.gz
    cp -rf $DIR/$GITHUB_ACCOUNT-$REPOSITORY-*/* $DIR
    rm -rf $DIR/$GITHUB_ACCOUNT-$REPOSITORY-*
    rm -rf $DIR/tmp/*
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
        $DIR

    printf "\n"
}

function program_setup {

    chmod 700 $DIR/{bin,lib,sbin,usr,usr/bin,test,test/bin,tmp}
    chmod 500 $DIR/{bin,usr/bin,test/bin}/*
    chmod 500 $DIR/setup.sh

    # detect operating system
    source $DIR/etc/bash/.bash_system
    # make available custom scripts
    export PATH=$PATH:$DIR/bin:$DIR/usr/bin

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
    if [ $DIST != "macosx" ] \
            && [ $DIST != "ubuntu" ] \
            && [ $DIST != "debian" ] \
            && [ $DIST != "centos" ] \
            && [ $DIST != "scientific" ]; then
        print_err "Operating system is not fully supported"
    fi

    # update
    [ -n "$arg_update" ] && (. $DIR/sbin/update.sh $*)
    # prepare
    [ -n "$arg_prepare" ] && (. $DIR/sbin/prepare.sh $*)
    # install
    [ -n "$arg_install" ] && (. $DIR/sbin/install.sh $*)
    # config
    [ -n "$arg_config" ] && (. $DIR/sbin/config.sh $*)
    # test
    [ -n "$arg_test" ] && /bin/bash -cli "system_test --skip-selected-tests"

    # remove not needed resources
    if [ -n "$arg_minimal" ]; then
        rm -rf $DIR/{etc,doc,sbin,test,LICENCE*,Makefile,provision.sh,README*,setup.sh,Vagrantfile}
    fi
    rm -rf $DIR/{.gitignore,tmp/*}
}

function should_install {

    item=$1
    file=$2

    if [ "$item" == "system" ] || [ "$item" == "common" ] || [ "$item" == "server" ] || [ "$item" == "workstation" ]; then
        _is_on_list "$item" "$arg_install_groups"
        return $?
    fi

    _should_proceed "$arg_install_groups" "$item" "$file"
}

function should_config {

    item=$1
    file=$2

    _should_proceed "$arg_config_progs" "$item" "$file"
}

function should_update {

    item=$1
    file=$2

    _should_proceed "$arg_update_progs" "$item" "$file"
}

function _should_proceed {

    list=$1
    item=$2
    file=$3

    _is_exec "$item" "$file"
    [ $? -ne 0 ] && return 1

    _is_on_list "$item" "$list"
    return $?
}

function _is_exec {

    name=$1
    file=$2

    if [ -n "$file" ]; then
        [ ! -x "$file" ] && return 1
    else
        which "$name" > /dev/null 2>&1 || return 1
    fi

    return 0
}

function _is_on_list {

    item=$1
    list=$2

    [ -z "$list" ] && return 0

    echo "$list" | grep "^${item}$" > /dev/null 2>&1 && return 0 # is a
    echo "$list" | grep "^${item}," > /dev/null 2>&1 && return 0 # starts with
    echo "$list" | grep ",${item}$" > /dev/null 2>&1 && return 0 # ends with
    echo "$list" | grep ",${item}," > /dev/null 2>&1 && return 0 # contains

    return 1
}

################################################################################
# main

[ -n "$arg_help" ] && usage
[ -n "$arg_sudo" ] && sudo_keep_alive
[ -n "$arg_directory" ] && DIR=$arg_directory

if [ -z "$BASH_SOURCE" ] || [ -n "$arg_force_download" ]; then

    # download from repository
    program_download

elif [[ $program_dir == */projects/$REPOSITORY ]] || [[ $program_dir == */projects/stefaniuk/$REPOSITORY ]] || [[ $program_dir == /project ]]; then

    # synchronise with project
    program_synchronise

fi

# perform post-install configuration
program_setup $*

exit 0
