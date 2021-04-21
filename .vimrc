
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/zacanger/angr.vim.git'
Plug 'https://github.com/itchyny/lightline.vim.git'

call plug#end()

set splitright "open vsplit files on the right side"

set laststatus=2 " lightline
set noshowmode " get rid of -- insert --

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab " use spaces instead of spaces.
set smarttab
set shiftround 
set autoindent
set smartindent

" Sane search
set ignorecase " case insensitive search
set smartcase " if there are uppercase letters, become case-sensitive
set hlsearch " highlight search
set incsearch " make search act like in modern browsers

set showmatch " show matching brackets

set backspace=indent,eol,start

" relative number in normal mode
:set number relativenumber
" norelative number in insert mode
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber

:augroup END

" turn backup off
set nobackup
set nowb 
set noswapfile

set autoread "auto read when a file is changed from outside

set wildmenu " tab completion menu

:color angr

syntax on

