#!/bin/sh

# load MintLeaf
export MINTLEAF_HOME=/usr/local/mintleaf
source $MINTLEAF_HOME/bin/bootstrap

# case-insensitive globbing
shopt -s nocaseglob
# auto-correct typos in path names when using `cd`
shopt -s cdspell
# allows `cd **/qux` to enter `./foo/bar/baz/qux`
shopt -s autocd
# pattern `**` used in a file name expansion context will match all files and zero or more directories and subdirectories
shopt -s globstar

# bash completion
if [[ -r /etc/bash_completion ]]; then
    source /etc/bash_completion
elif [[ -r /usr/local/etc/bash_completion ]]; then
    source /usr/local/etc/bash_completion
fi
# grc
if [[ -f $(brew --prefix grc)/etc/grc.bashrc ]]; then
    source $(brew --prefix grc)/etc/grc.bashrc
fi
# ssh host names completion based on ~/.ssh/config
[[ -e ~/.ssh/config ]] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" ssh scp sftp

# load dotfiles
for file in ~/.{path,bash_prompt,bashrc.*,exports*,functions*,aliases*,extra}; do
    [[ -r $file ]] && source $file
done
unset file

# make sure PATH variable includes `bin` directories in the right order
export PATH=~/bin:/usr/local/bin:$PATH
