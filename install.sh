#!/bin/bash

# iTerm
cp -fv ./Library/Preferences/com.googlecode.iterm2.plist ~/Library/Preferences

# Vim
rm -rf ~/.vim
mkdir -p ~/.vim
cp -Rfv ./.vim/* ~/.vim
cp -fv ./.vimrc ~
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone -v https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
    (cd ~/.vim/bundle/Vundle.vim; git pull -v)
fi

# Midnight Commander
rm -rf ~/.config/mc
mkdir -p ~/.config
cp -Rv ./.config/mc ~/.config

# Sublime Text
rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
cp -fv ./Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
cp -fv ./Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default\ \(OSX\).sublime-keymap ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

exit 0
