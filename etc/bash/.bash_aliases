#!/bin/sh

# --- navigation ---------------------------------------------------------------

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias -- -="cd -"

# --- shortcuts ----------------------------------------------------------------

alias dl="cd ~/Downloads"
alias p="cd ~/projects"

alias g="git"
alias ga="git add -A"
alias gb="git branch -vv"
alias gc="git commit -a"
alias gco="git checkout"
alias gd="git diff"
alias gl="git log --graph --stat --oneline --decorate"
alias gm="git merge --no-ff"
alias gp="git push"
alias gpo="git push origin"
alias gs="git status -s"

alias d="docker"
alias dup="docker -d -H unix:///var/run/docker.sock -D >> /var/log/docker.log 2>&1 &"
alias dim="docker images"
alias dps="docker ps -a"
alias dst="docker start"
alias dto="docker top"
alias dlo="docker logs -f"
alias dex="docker exec -it"
alias dat="docker attach"
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
function dbu { docker build -t $GITHUB_ACCOUNT/$(basename $(pwd) | sed s/docker-//) --rm . ; }
export -f dbu

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

# ip address
alias ipi="ifconfig | \grep -oE '192\.168\.[0-9]+\.[0-9]+' | \grep -v '.255$' | sort | uniq"
alias ipe="net_get_external_ip"

# canonical hex dump
command -v hd > /dev/null || alias hd="hexdump -C"

# url encode strings
alias urlencode="python -c 'import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);'"

# colourise output of some commands
if which grc > /dev/null 2>&1; then
    [ -d /usr/local/share/grc ] && dir=/usr/local/share/grc || dir=/usr/share/grc
    for file in $(ls -1 $dir); do
        prog=$(echo $file | awk 'BEGIN { FS = "." } ; { print $2 }')
        alias $prog="grc -es --colour=auto $prog"
    done
    unset dir file prog
fi

# show manual
alias sb="show-manual best-practices"
alias sc="show-manual cheat-sheets"
alias sd="show-manual design-patterns"
alias se="show-manual settings"
alias st="show-manual templates"

# reload bash
alias reload="exec $SHELL -l"
# sync bash
alias synchronise="(cd ~/projects/dotfiles; ./setup.sh --synchronise-only); exec $SHELL -l"

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
