#!/bin/sh

# navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias -- -="cd -"

# shortcuts
alias dl="cd ~/Downloads"
alias p="cd ~/projects"
alias pd="cd ~/projects/dotfiles"
alias pm="cd ~/projects/mintleaf/src"
alias g="\git"

# remove colour codes from the output
alias ccr='color_codes_remove'

# list files - detect which `ls` flavour is in use
if [ $DIST == "macosx" ]; then # OS X `ls`
    colorflag="-G"
else # GNU `ls`
    colorflag="--color"
fi
# always use colour output for `ls`
alias ls="\ls ${colorflag}"
# list all files colourised in long format
alias ll="\ls -lF ${colorflag}"
# list all files colourised in long format, including dot files
alias la="\ls -laF ${colorflag}"
# list only directories
alias lsd="\ls -lF ${colorflag} | grep --color=never '^d'"

# always use colour output for `grep`
alias grep="\grep --color=auto"

# enable aliases to be sudo’ed
alias sudo="sudo "

# ip address
alias ip="\ifconfig | grep -oE '192\.168\.[0-9]+\.[0-9]+' | grep -v '.255$'"
alias ipe="net_get_external_ip"

# canonical hex dump
command -v hd > /dev/null || alias hd="hexdump -C"

# url encode strings
alias urlencode="python -c 'import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);'"

# colourise output of some commands
if which grc > /dev/null; then
    [ -d /usr/local/share/grc ] && dir=/usr/local/share/grc || dir=/usr/share/grc
    for file in $(\ls -1 $dir); do
        prog=$(echo $file | awk 'BEGIN { FS = "." } ; { print $2 }')
        which grc > /dev/null && alias $prog="grc $prog"
    done
    unset dir file prog
fi

# show shortcuts/commands
alias ss="show_shortcuts"
alias sc="show_commands"

# reload bash
alias reload="exec $SHELL -l"
# sync bash
alias synchronise="(cd ~/projects/dotfiles; ./bin/install.sh --common-only); exec $SHELL -l"
