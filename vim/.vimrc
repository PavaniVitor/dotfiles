set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/itchyny/lightline.vim.git'
Plug 'https://github.com/vim-scripts/xoria256.vim.git' 
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/ycm-core/YouCompleteMe.git'
call plug#end()


" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

set splitbelow "open split below
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

" move lines with <C-j><C-h>
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv


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

" YouCompleteMe stuff
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

let g:ycm_language_server =
  \ [{
  \   'name': 'ccls',
  \   'cmdline': [ 'ccls' ],
  \   'filetypes': [ 'c', 'cpp', 'cuda', 'objc', 'objcpp' ],
  \   'project_root_files': [ '.ccls-root', 'compile_commands.json' ]
  \ }]

nnoremap <leader>gt :YcmCompleter GoTo<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>


