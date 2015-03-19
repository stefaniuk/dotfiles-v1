""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vundle
set nocompatible
filetype off                                                                    " required
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
" all of your plug-ins must be added before the following line
call vundle#end()
filetype plugin indent on                                                       " required

" pathogen
call pathogen#infect()
syntax on
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SEE: https://github.com/justinforce/dotfiles/blob/master/files/vimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" appearance
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termtrans=1
let g:solarized_termcolors=256
set t_Co=256
colorscheme solarized

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" behaviour
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set ruler                                                                       " show cursor position in status bar
set number                                                                      " show absolute line number of the current line
set hidden                                                                      " don't unload buffer when switching away
set modeline                                                                    " allow per-file settings
set secure                                                                      " disable unsafe commands in local .vimrc files
set backspace=indent,eol,start                                                  " make backspacing working in insert mode
set autoread                                                                    " reload file
set ffs=unix,dos,mac                                                            " file format
set encoding=utf-8 fileencoding=utf-8 termencoding=utf-8                        " encoding
set nobackup nowritebackup noswapfile                                           " no backup or swap
set hlsearch incsearch ignorecase smartcase                                     " search
set wildmenu                                                                    " completion
set clipboard=unnamed,unnamedplus                                               " use the system clipboard for yank/put/delete
set mouse=a                                                                     " enable mouse for all modes settings
set nomousehide                                                                 " don't hide the mouse cursor while typing
set mousemodel=popup                                                            " right-click pops up context menu
set nofoldenable                                                                " no folding
set scrolloff=10                                                                " scroll the window to show lines around the cursor
set laststatus=2                                                                " always show status bar
set nowrap
set autoindent                                                                  " auto indentation
set copyindent                                                                  " copy the previous indentation on autoindenting
set smarttab                                                                    " insert tabs on the start of a line
set tabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=80
set virtualedit=all
set list                                                                        " displays whitespace
set listchars=eol:$,tab:»·,trail:·,extends:>,precedes:<
set undolevels=1000
set history=100
set cursorline                                                                  " highlight the current line
set cursorcolumn                                                                " highlight the current column
let &colorcolumn="80,".join(range(120,500),",")                                 " highlight column 80 and from 120
set shell=bash

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" mapping <Shift>-arrows to select characters/lines
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
