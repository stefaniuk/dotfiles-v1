#!/bin/sh

# open directory in Vim editor
function v() {

    if [[ $# -eq 0 ]]; then
        vim .
    else
        vim "$@"
    fi
}

# open directory in Sublime Text editor
function s() {

    if [[ $# -eq 0 ]]; then
        subl .
    else
        subl "$@"
    fi
}

# open web page in Lynx browser
function l() {

    if [[ $# -eq 0 ]]; then
        lynx "https://google.co.uk/"
    else
        lynx "$@"
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

    tree -aC -I "
        |.git*|README*|LICENCE*|LICENSE*|
        |.classpath|.project|.settings|target|
        |vendor|*_*.po|*_*.mo|
        |bower_components|node_modules|
        |*.lock|*.tmp|*.bak|*.old" \
        --dirsfirst "$@" | less -FRNX
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

# start `php` application
function runphp {

    local port="${1:-9000}"

    local dir=
    if [ -d ./public ] && [ -f ./public/index.php ]; then
        dir="."
    elif [ -d ../public ] && [ -f ../public/index.php ]; then
        dir=".."
    elif [ -d ../../public ] && [ -f ../../public/index.php ]; then
        dir="../.."
    elif [ -d ../../../public ] && [ -f ../../../public/index.php ]; then
        dir="../../.."
    fi

    if [ -n "$dir" ]; then
        local pid=$(ps aux | grep -v 'grep' | grep 'php -S 0.0.0.0:9000 -t ./public ./public/index.php' | awk '{ print $2 }')
        [ -n "$pid" ] && kill -s TERM $pid
        (
            cd ${dir}
            nohup php -S 0.0.0.0:${port} -t ./public ./public/index.php > ~/php.log &
        )
        tail -f ~/php.log
    fi
}

# change github protocol from https to git
function fix_github_urls() {

    for file in $(find ~/projects -type f -iname config | grep '\.git'); do
        file_replace_str "url = https://github.com/stefaniuk" "url = git@github.com:stefaniuk" $file
    done
}

# show shortcuts
function show_shortcuts() {

    if [ "$1" == "-l" ] || [ "$1" == "--list" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
        \ls -1 ~/projects/shortcuts | \
            grep -v README.md | grep -v LICENCE | \
            sed 's/\.md//g'
        return
    fi

    local prog="${1:-general}"
    local desc="${2:-xxx}"
    for file in $(\ls -1 ~/projects/shortcuts/*${prog}*.md 2> /dev/null); do
        [[ $file == *README.md ]] && continue
        echo
        cat $file | \
            sed "s/^#### /`printf "${bold}${white}"`#### /g" | \
            sed "s/^##### /`printf "${blue}"`##### /g" | \
            sed ":a;N;\$!ba;s/\n/${reset}\n/g" | \
            egrep --color -i "${desc}|$"
        echo
    done
}

# show commands
function show_commands() {

    if [ "$1" == "-l" ] || [ "$1" == "--list" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
        \ls -1 ~/projects/commands | \
            grep -v README.md | grep -v LICENCE | \
            sed 's/\.md//g'
        return
    fi

    local prog="${1:-general}"
    local desc="${2:-xxx}"
    for file in $(\ls -1 ~/projects/commands/*${prog}*.md 2> /dev/null); do
        [[ $file == *README.md ]] && continue
        echo
        cat $file | \
            sed "s/^#### /`printf "${bold}${white}"`#### /g" | \
            sed "s/^##### /`printf "${blue}"`##### /g" | \
            sed ":a;N;\$!ba;s/\n/${reset}\n/g" | \
            egrep --color -i "${desc}|$"
        echo
    done
}
