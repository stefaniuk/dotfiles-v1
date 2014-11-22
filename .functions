#!/bin/sh

# `v` opens directory in Vim editor
function v() {

    if [[ $# -eq 0 ]]; then
        vim .
    else
        vim "$@"
    fi
}

# `s` opens directory in Sublime Text editor
function s() {

    if [[ $# -eq 0 ]]; then
        subl .
    else
        subl "$@"
    fi
}

# determine size of a file or total size of a directory
function fs() {

    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh
    else
        local arg=-sh
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@"
    else
        du $arg .[^.]* *
    fi
}

# `tre` is an improved `tree`
function tre() {

    tree -aC -I ".classpath|.git|.project|.settings|bower_components|node_modules|target" --dirsfirst "$@" | less -FRNX
}

# use git's coloured `diff`
function diff() {

    git diff --no-index --color-words "$@"
}

# get base64 data url of a file
function dataurl() {

    local mt=$(file -b --mime-type "$1")
    if [[ $mt == text/* ]]; then
        mt="${mt};charset=utf-8"
    fi
    echo "data:${mt};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# convert string to unicode
function escape() {

    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
    # print new line unless we're piping output to another program
    if [[ -t 1 ]]; then
        echo ""
    fi
}

# convert string from \x{ABCD}-style unicode
function unidecode() {

    perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
    # print new line unless we're piping output to another program
    if [[ -t 1 ]]; then
        echo ""
    fi
}

# get character's unicode code point
function codepoint() {

    perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))"
    # print new line unless we're piping output to another program
    if [[ -t 1 ]]; then
        echo ""
    fi
}
