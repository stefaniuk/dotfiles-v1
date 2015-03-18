""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vundle
set nocompatible
filetype off                                                                    " required
set rtp+=~/.vim/bundle/Vundle.vim
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

set number              " show absolute line number of the current line
set ruler               " show cursor position in status bar
set nowrap
set autoindent          " auto indentation
set copyindent          " copy the previous indentation on autoindenting
set smarttab            " insert tabs on the start of a line according to context
set tabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=80
set virtualedit=all
set list
set listchars=eol:$,tab:»·,trail:·,extends:>,precedes:<
filetype plugin indent on
syntax on
set undolevels=1000
set history=100

" SEE: https://github.com/justinforce/dotfiles/blob/master/files/vimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" appearance
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
set background=dark
set t_Co=256                                                                    " enable 256 colours
colorscheme solarized                                                           " set colour scheme
let &colorcolumn="80,".join(range(120,500),",")                                 " highlight column 80 and from 120

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" behaviour
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autoread                                                                    " reload file
set ffs=unix,dos,mac                                                            " file format
set encoding=utf-8 fileencoding=utf-8 termencoding=utf-8                        " encoding

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
