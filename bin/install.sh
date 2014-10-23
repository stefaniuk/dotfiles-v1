#!/bin/bash

cd $(dirname $BASH_SOURCE)

USER_NAME="Daniel Stefaniuk"
USER_EMAIL="daniel.stefaniuk@gmail.com"

function title() {
    tput bold
    echo "$1"
    tput sgr 0
}
function info() {
    tput setaf 3
    echo "    $1"
    tput sgr 0
}
function error() {
    tput setaf 1
    echo "$1"
    tput sgr 0
}

wget --quiet --timeout=10 --tries=3 --spider https://google.com
if [[ $? -ne 0 ]]; then
    error "No internet connection"
    exit 2
fi

# Mac OS X
if [[ "$OSTYPE" == "darwin"* ]]; then
    . ./config-osx
else
    error "System not supported"
    exit 1
fi

exit 0
