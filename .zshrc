#!/bin/sh

export PATH=~/bin:/usr/local/bin:$PATH

# load Oh My Zsh
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell" plugins=(git) source $ZSH/oh-my-zsh.sh

# load dotfiles
#for file in ~/.{path,exports*,functions*,aliases*,extra}; do
#    [[ -r $file ]] && source $file
#done
#unset file
