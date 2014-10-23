#!/bin/bash

# update the user's cached credentials, authenticating the user if necessary
sudo -v
# keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

################################################################################
# Git                                                                          #
################################################################################

print_title "Git"
GIT_AUTHOR_NAME="$USER_NAME"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="$USER_EMAIL"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
git config --global push.default simple

exit 0
