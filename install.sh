#!/bin/bash

# iterm
cp -f iterm/com.googlecode.iterm2.plist ~/Library/Preferences

# vim
rm -rf ~/.vim
cp -Rf vim ~/.vim
cp -f .vimrc ~
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# mc
rm -rf ~/.config/mc
mkdir -p ~/.config
cp -R mc ~/.config/mc

exit 0
