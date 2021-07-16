
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/itchyny/lightline.vim.git'
Plug 'https://github.com/vim-scripts/xoria256.vim.git' 
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/davidhalter/jedi-vim.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/vim-scripts/AutoClose.git'
call plug#end()

" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

set splitright "open vsplit files on the right side"
set tags+=~/.vim/tags/ros/tags

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

" faster scrool with C-e C-y
nnoremap <C-y> 5<C-y>
nnoremap <C-e> 5<C-e>
" insert newline with enter in normal mode


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

:color xoria256 

set showcmd
syntax on

" netrw tweaks
let g:netrw_banner=0        " disable banner
let g:netrw_liststyle=3     " tree view
let g:netrw_altv=1          " open split to the right

" remove the annoying esc delay
set ttimeoutlen=5

set makeprg=catkin_make

set statusline+=%#warningmsg#
set statusline+=%*

" turn on omnicompletion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

