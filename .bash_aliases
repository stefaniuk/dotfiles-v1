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
alias g="git"

# list files - detect which `ls` flavour is in use
if [ $DIST == "macosx" ]; then # OS X `ls`
    colorflag="-G"
else # GNU `ls`
    colorflag="--color"
fi
# list all files colourised in long format
alias ll="ls -lF ${colorflag}"
# list all files colourised in long format, including dot files
alias la="ls -laF ${colorflag}"
# list only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"
# always use colour output for `ls`
alias ls="command ls ${colorflag}"

# search
alias grep="grep --color=auto"

# enable aliases to be sudo’ed
alias sudo="sudo "

# ip address
alias ip="ifconfig | grep -oE '192.168.[0-9]+.[0-9]+' | grep -v '.255$'"
alias ipe="net_get_external_ip"

# canonical hex dump
command -v hd > /dev/null || alias hd="hexdump -C"

# url encode strings
alias urlencode="python -c 'import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);'"

# reload bash
alias re="exec $SHELL -l"
# sync bash
alias sy="(cd ~/projects/dotfiles; ./bin/install.sh --common-only; exec $SHELL -l)"
