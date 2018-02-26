#!/bin/bash

_dotfiles()
{
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"
    local opts="--update-os --install --config --test --synchronise-only --force-download --directory --minimal --sudo --help"
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
}

complete -F _dotfiles dotfiles
