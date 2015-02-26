#!/bin/sh

#### dependencies ##############################################################

# load Oh My Zsh
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell" plugins=(git) source $ZSH/oh-my-zsh.sh

#### configuration #############################################################

# TODO

#### resources #################################################################

# load dotfiles
for file in ~/.{path,zshrc.*,zsh_prompt,zsh_exports*,zsh_functions*,zsh_aliases*,zsh_completion*,zsh_extra,zsh_custom}; do
    [[ -r $file ]] && source $file
done
unset file

# make sure PATH variable includes `bin` directories in the right order
export PATH=~/bin:/usr/local/bin:$PATH
