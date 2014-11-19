export PATH=~/bin:/usr/local/bin:$PATH

# load Oh My Zsh
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell" plugins=(git) source $ZSH/oh-my-zsh.sh

# load dotfiles
source ~/.exports
source ~/.functions
source ~/.aliases