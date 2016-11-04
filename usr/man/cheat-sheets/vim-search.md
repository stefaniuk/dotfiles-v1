# Vim Search

## Basic

In normal mode you can search forwards by pressing `/` then typing your search pattern. Press `Esc` to cancel or press `Enter` to perform the search. Then press `n` to search forwards for the next occurrence, or `N` to search backwards. Type `ggn` to jump to the first match, or `GN` to jump to the last.

## Advanced

Search backwards by pressing `?` then typing your search pattern. Pressing `n` searches in the same direction (backwards), while `N` searches in the opposite direction (forwards).

In normal mode, move the cursor to any word. Press `*` to search forwards for the next occurrence of that word, or press `#` to search backwards.

Using `*` or `#` searches for the exact word at the cursor (searching for rain would not find rainbow). Use `g*` or `g#` if you don't want to search for the exact word.

Type `/` or `?` and use the arrow `up/down` keys to recall previous search patterns. You can edit a pattern, and press `Enter` to search for something different.

Suppose the cursor is on a word, and you want to search for a similar word. Press `/` then `Ctrl-r` then `Ctrl-w` to copy the current word to the command line. You can now edit the search pattern and press `Enter`.

## Tips

##### Highlighting

Use command `:noh` or alternatively put this in the configuration file `nmap <SPACE> <SPACE>:noh<CR>` to clear highlighting until the next search. Pressing space in normal mode will still do what space did, usually advance one character but also will clear the highlighting.

## Commands

    /string         search
    /string\c       case insensitive
    /string\C       case sensitive
    /\<string\>     whole-word
    :g/string       list all lines containing string
    :noh            clear highlighting
    :h pattern      help
