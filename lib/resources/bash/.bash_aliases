#!/bin/sh

# --- navigation ---------------------------------------------------------------

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias -- -="cd -"

# --- shortcuts ----------------------------------------------------------------

alias g="git"
alias ga="git add"
alias gb="git branch -vv"
alias gb+="git branch -vv --all"
alias gc="git commit"
alias gc+="git commit --all"
alias gco="git checkout"
alias gco+="git checkout -b"
alias gd="git diff"
alias gd+="git diff --cached"
alias gl="git log --graph --oneline --decorate"
alias gl+="git log --graph --oneline --decorate --stat"
alias gf="git fetch --prune"
alias gp="git pull"
alias gp+="git push --set-upstream origin"
alias gm="git merge --no-ff"
alias gs="git status --short"
alias gr="git reset HEAD"
alias gr+="git reset --hard HEAD"
alias gr++="git reset --hard HEAD~1"
alias git-prune='git fetch --prune && for branch in `git branch -vv | grep ": gone]" | awk "{print $1}"`; do git branch --delete $branch; done'

alias d="docker"
alias dim="docker images"
alias dps="docker ps --all"
alias dst="docker start"
alias dto="docker top"
alias dlo="docker logs --follow"
alias dex="docker exec --interactive --tty"
alias dat="docker attach"
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias drc='docker rm --force $(docker ps --all --quiet) 2> /dev/null'
alias drv='docker volume rm $(docker volume ls --quiet --filter dangling=true) 2> /dev/null'
alias dri='docker rmi --force $(docker images | grep "<none>" | awk "{print $3}") 2> /dev/null'
alias dri-own='docker rmi --force $(docker images | grep "$GITHUB_ACCOUNT" | awk "{print $3}") 2> /dev/null'

alias tmux="TERM=screen-256color-bce tmux"

# --- commands -----------------------------------------------------------------

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
alias lsd="ls -lF ${colorflag} | \grep --color=never '^d'"

# always use colour output for `grep`
alias grep="\grep --color=auto"

# enable aliases to be sudo'ed
alias sudo="sudo "

# IP address
alias ipi="ifconfig | \grep -oE '(10\.[0-9]+\.[0-9]+\.[0-9]+|172\.(1[6-9]|2[0-9]|3[0-1])\.[0-9]+\.[0-9]+|192\.168\.[0-9]+\.[0-9]+)' | \grep -v '.255$' | sort | uniq"
alias ipe="net_get_external_ip"

# canonical hex dump
command -v hd > /dev/null || alias hd="hexdump -C"

# colourise output of some commands
if which grc > /dev/null 2>&1; then
    [ -d /usr/local/share/grc ] && dir=/usr/local/share/grc || dir=/usr/share/grc
    for file in $(ls -1 $dir); do
        prog=$(echo $file | awk 'BEGIN { FS = "." } ; { print $2 }')
        alias $prog="grc -es --colour=auto $prog"
    done
    unset dir file prog
fi

# gtypist
if which gtypist > /dev/null 2>&1; then
    alias gtypist="gtypist \
        --personal-best \
        --max-error=5.0 \
        --term-cursor \
        --silent \
        --word-processor \
        --show-errors \
        --always-sure \
        --scoring=cpm"
fi

# reload bash
alias reload="exec $SHELL -l"
# sync bash
alias synchronise="([ -d ~/projects/dotfiles ] && cd ~/projects/dotfiles || cd ~/projects/$GITHUB_ACCOUNT/dotfiles; ./dotfiles --synchronise-only); exec $SHELL -l"

################################################################################
# macosx

if [ $DIST == "macosx" ]; then

    # trim new lines and copy to clipboard
    alias c="tr -d '\n' | pbcopy"

    # get software updates
    alias update="sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup"

    # recursively delete `.DS_Store` files and log files from home directory
    alias cleanup="sudo find . -type f -name '.DS_Store' -print0 | xargs -0 rm -v"

    # empty the Trash on all mounted volumes and the main drive and clear system logs
    alias emptytrash="sudo rm -rfv ~/.Trash; sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv /private/var/log/asl/*.asl"

    # hide/show hidden files in Finder
    alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
    alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"

    # hide/show desktop icons
    alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
    alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

fi
