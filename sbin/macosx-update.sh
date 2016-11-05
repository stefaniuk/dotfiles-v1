#!/bin/bash

################################################################################

if ! which brew > /dev/null; then
    softwareupdate --install -all
    xcode-select --install
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap homebrew/dupes
    brew tap homebrew/versions
    brew tap homebrew/homebrew-php
    brew tap caskroom/versions
    brew install caskroom/cask/brew-cask
fi
brew update
brew upgrade

################################################################################

brew cleanup
brew cask cleanup

exit 0
